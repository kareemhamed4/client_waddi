import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/layout/user/cubit/states.dart';
import 'package:waddy_app/models/common/message_model.dart';
import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/user/home/home_screen.dart';
import 'package:waddy_app/modules/user/inbox/inbox_screen.dart';
import 'package:waddy_app/modules/user/my_orders/my_order_screen.dart';
import 'package:waddy_app/modules/user/profile/profile_screen.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class UserLayoutCubit extends Cubit<UserLayoutStates> {
  UserLayoutCubit() : super(UserInitialState());
  static UserLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> get screens {
    if (uId == "ekkODsmM09YBM8FggBbRw078Qfv1") {
      return [
        const UserInboxScreen(),
        const UserProfileScreen(),
      ];
    } else {
      return [
        const UserHomeScreen(),
        const UserMyOrderScreen(),
        const UserInboxScreen(),
        const UserProfileScreen(),
      ];
    }
  }

  List<BottomNavigationBarItem> get bottomItems {
    if (uId == "ekkODsmM09YBM8FggBbRw078Qfv1") {
      return [
        const BottomNavigationBarItem(
          icon: Icon(CustomIcons.chat),
          label: 'Inbox',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CustomIcons.user_alt),
          label: 'Profile',
        ),
      ];
    } else {
      return [
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CustomIcons.doc_text_inv),
          label: 'My Order',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CustomIcons.chat),
          label: 'Inbox',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CustomIcons.user_alt),
          label: 'Profile',
        ),
      ];
    }
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarUserState());
  }

  UserInfo? userInfo;
  Future<void> getUserData() async {
    emit(GetUserInfoLoadingState());
    await DioHelper.getData(
      url: GETUSERINFO,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      userInfo = UserInfo.fromJson(value.data);
      emit(GetUserInfoSuccessState(userInfo!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetUserInfoErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(GetUserInfoErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(GetUserInfoErrorState('An error occurred. Please try again.'));
      }
    });
  }

  UserModelFB? userModelFB;
  void getUserDataFromFB() async {
    emit(GetUserFromFBLoadingState());
    await getUserData();
    if (userInfo == null) {
      emit(GetUserFromFBErrorState('User info is null.'));
      return;
    }
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      userModelFB = UserModelFB.fromJson(value.data()!);
      emit(GetUserFromFBSuccessState());
    }).catchError((error) {
      emit(GetUserFromFBErrorState(error.toString()));
    });
  }

  List<UserModelFB> delegates = [];
  void getAllDelegatesFromFB() {
    emit(GetAllDelegatesFromFBLoadingState());
    if (delegates.isEmpty) {
      FirebaseFirestore.instance.collection('Delegates').get().then((value) {
        for (var element in value.docs) {
          if (element.data()["uId"] != userModelFB!.uId) {
            delegates.add(UserModelFB.fromJson(element.data()));
          }
        }
        emit(GetAllDelegatesFromFBSuccessState());
      }).catchError((error) {
        emit(GetAllDelegatesFromFBErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModelFB!.uId,
      receiverId: receiverId,
      dateTime: DateTime.now().toIso8601String(),
      text: text,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModelFB!.uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    //set receiver chats
    FirebaseFirestore.instance
        .collection("Delegates")
        .doc(receiverId)
        .collection("Chats")
        .doc(userModelFB!.uId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<UserModelFB> delegatesWithChat = [];
  Future<void> getDelegatesWithChat() async{
    emit(GetDelegatesWithChatLoadingState());
    await getAllMessages();
    if (delegates.isEmpty) {
      FirebaseFirestore.instance
          .collection('Delegates')
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (element.data()["uId"] != userModelFB!.uId) {
            delegates.add(UserModelFB.fromJson(element.data()));
          }
        }

        for (var user in delegates) {
          FirebaseFirestore.instance
              .collection("Users")
              .doc(userModelFB!.uId)
              .collection("Chats")
              .doc(user.uId)
              .collection("Messages")
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              delegatesWithChat.add(user);
            }
          }).whenComplete(() {
            getAllMessages();
            emit(GetDelegatesWithChatSuccessState(delegatesWithChat));
          }).catchError((error) {
            emit(GetDelegatesWithChatErrorState(error.toString()));
          });
        }
      }).catchError((error) {
        emit(GetAllDelegatesFromFBErrorState(error.toString()));
      });
    }
  }

  List<MessageModel> messages = [];
  Map<String, MessageModel?> lastMessages = {};
  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModelFB!.uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messages = event.docs
          .map((element) => MessageModel.fromJson(element.data()))
          .toList();

      if (messages.isNotEmpty) {
        lastMessages[receiverId] = messages.last;
      } else {
        lastMessages[receiverId] = null;
      }
      emit(ReceiveMessageSuccessState());
    });
  }

  Future<void> getAllMessages() async {
    for(int i=0; i<delegatesWithChat.length ; i++){
      getMessages(receiverId: delegatesWithChat[i].uId!);
    }
  }
}
