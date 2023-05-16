import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waddy_app/models/common/message_model.dart';
import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/user/profile/cubit/states.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  static UserProfileCubit get(context) => BlocProvider.of(context);

  UserInfo? userInfo;
  Future<void> getUserData() async{
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

  var picker = ImagePicker();

  File? profileImage;
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  UserModelFB? userModelFB;
  void getUserDataFromFB() async{
    emit(GetUserFromFBLoadingState());
    await getUserData();
    if (userInfo == null) {
      emit(GetUserFromFBErrorState('User info is null.'));
      return;
    }
    FirebaseFirestore.instance
        .collection(
        userInfo!.companyName == null
            ? 'Users'
            : 'Companies')
        .doc(uId)
        .get()
        .then((value) {
      userModelFB = UserModelFB.fromJson(value.data()!);
      emit(GetUserFromFBSuccessState());
    }).catchError((error) {
      emit(GetUserFromFBErrorState(error.toString()));
    });
  }

  List<UserModelFB> users = [];
  void getAllUsersFromFB() {
    emit(GetAllUsersFromFBLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('Users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()["uId"] != userModelFB!.uId) {
            users.add(UserModelFB.fromJson(element.data()));
          }
        }
        emit(GetAllUsersFromFBSuccessState());
      }).catchError((error) {
        emit(GetAllUsersFromFBErrorState(error.toString()));
      });
    }
  }

  List<UserModelFB> companies = [];
  void getAllCompaniesFromFB() {
    emit(GetAllCompaniesFromFBLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('Companies').get().then((value) {
        for (var element in value.docs) {
          if (element.data()["uId"] != userModelFB!.uId) {
            companies.add(UserModelFB.fromJson(element.data()));
          }
        }
        emit(GetAllCompaniesFromFBSuccessState());
      }).catchError((error) {
        emit(GetAllCompaniesFromFBErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required BuildContext context,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModelFB!.uId,
      receiverId: receiverId,
      dateTime: DateTime.now().toIso8601String(),
      text: text,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection(
        context.read<UserProfileCubit>().userInfo!.companyName == null
            ? 'Users'
            : 'Companies')
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
        .collection('Companies')
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

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
    required BuildContext context,
  }) {
    FirebaseFirestore.instance
        .collection(context.read<UserProfileCubit>().userInfo!.companyName == null ? 'Users' : 'Companies')
        .doc(userModelFB!.uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .orderBy("dateTime", descending: false)
        .snapshots()
        .listen((event) {
          messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(ReceiveMessageSuccessState());
    });
  }
}
