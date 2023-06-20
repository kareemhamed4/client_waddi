import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:waddy_app/layout/driver/cubit/states.dart';
import 'package:waddy_app/models/common/message_model.dart';
import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/driver/home/home_screen.dart';
import 'package:waddy_app/modules/driver/inbox/inbox_screen.dart';
import 'package:waddy_app/modules/driver/orders/orders_screen.dart';
import 'package:waddy_app/modules/driver/profile/profile_screen.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class DriverLayoutCubit extends Cubit<DriverLayoutStates> {
  DriverLayoutCubit() : super(DriverInitialState());
  static DriverLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    DriverHomeScreen(),
    DriverOrdersScreen(),
    SizedBox(),
    DriverInboxScreen(),
    DriverProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarDriverState());
  }

  UserInfo? delegateInfo;
  Future<void> getDelegateData() async {
    emit(GetDelegateInfoLoadingState());
    await DioHelper.getData(
      url: GETUSERINFO,
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      delegateInfo = UserInfo.fromJson(value.data);
      emit(GetDelegateInfoSuccessState(delegateInfo!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetDelegateInfoErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(GetDelegateInfoErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(GetDelegateInfoErrorState('An error occurred. Please try again.'));
      }
    });
  }

  UserModelFB? delegateModelFB;
  Future<void> getDelegateDataFromFB() async {
    emit(GetDelegateFromFBLoadingState());
    await getDelegateData();
    if (delegateInfo == null) {
      emit(GetDelegateFromFBErrorState('User info is null.'));
      return;
    }
    FirebaseFirestore.instance.collection('Delegates').doc(uId).get().then((value) {
      delegateModelFB = UserModelFB.fromJson(value.data()!);
      emit(GetDelegateFromFBSuccessState());
    }).catchError((error) {
      emit(GetDelegateFromFBErrorState(error.toString()));
    });
  }

  List<UserModelFB> users = [];
  Future<void> getAllUsersFromFB() async{
    emit(GetAllUsersFromFBLoadingState());
    await getDelegateDataFromFB();
    if (delegateModelFB != null) {
      FirebaseFirestore.instance.collection('Users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()["uId"] != delegateModelFB!.uId) {
            users.add(UserModelFB.fromJson(element.data()));
          }
        }
        emit(GetAllUsersFromFBSuccessState());
      }).catchError((error) {
        emit(GetAllUsersFromFBErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: delegateModelFB!.uId,
      receiverId: receiverId,
      dateTime: DateTime.now().toIso8601String(),
      text: text,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection("Delegates")
        .doc(delegateModelFB!.uId)
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
        .collection("Users")
        .doc(receiverId)
        .collection("Chats")
        .doc(delegateModelFB!.uId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<UserModelFB> usersWithChat = [];
  Future<void> getUsersWithChat() async{
    emit(GetUsersWithChatLoadingState());
    await getAllMessages();
    if (users.isEmpty) {
      FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (element.data()["uId"] != delegateModelFB!.uId) {
            users.add(UserModelFB.fromJson(element.data()));
          }
        }

        for (var user in users) {
          FirebaseFirestore.instance
              .collection("Delegates")
              .doc(delegateModelFB!.uId)
              .collection("Chats")
              .doc(user.uId)
              .collection("Messages")
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              usersWithChat.add(user);
            }
          }).whenComplete(() {
            getAllMessages();
            emit(GetUsersWithChatSuccessState(usersWithChat));
          }).catchError((error) {
            emit(GetUsersWithChatErrorState(error.toString()));
          });
        }
      }).catchError((error) {
        emit(GetAllUsersFromFBErrorState(error.toString()));
      });
    }
  }

  List<MessageModel> messages = [];
  Map<String, MessageModel?> lastMessages = {};
  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection("Delegates")
        .doc(delegateModelFB!.uId)
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
    for(int i=0; i<usersWithChat.length ; i++){
      getMessages(receiverId: usersWithChat[i].uId!);
    }
  }

  StreamSubscription<Position>? _positionStreamSubscription;

  final io.Socket socket = io.io("http://192.168.1.12:8080/", io.OptionBuilder().setTransports(['websocket']).build());

  Future<void> startLocationUpdates() async{
    await getDelegateDataFromFB();
    emit(UpdateLocationLoadingState());
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Minimum distance (in meters) before receiving updates
      ),
    ).listen((Position position) {
      // Call the update method with the new latitude and longitude values
      if (uId != null) {
        updateLocationInFirebase(position.latitude, position.longitude);
        emitUpdateLocationEvent(position.latitude, position.longitude);
      }
    });
  }

  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  void updateLocationInFirebase(double latitude, double longitude) {
    FirebaseFirestore.instance.collection(userToken != null ? 'Users' : 'Delegates').doc(uId).update({
      'latitude': latitude,
      'longitude': longitude,
    }).then((value) {
      emit(UpdateLocationSuccessState(latitude: latitude, longitude: longitude));
    }).catchError((error) {
      emit(UpdateLocationErrorState(error.toString()));
    });
  }

  connectSocket() {
    socket.onConnect((_) {
      debugPrint("Socket.IO Connected");
      // Emit updateLocation event
      if(delegateInfo != null){
        emitUpdateLocationEvent(currentLatitude ?? 0, currentLongitude ??0);
      }
    });

    socket.onConnectError((data) {
      debugPrint("Socket.IO Connection Error: $data");
    });

    socket.onDisconnect((_) {
      debugPrint("Socket.IO Disconnected");
    });

    // Listen for updateLocation event
    socket.on('updateLocation', (data) {
      debugPrint('Received updateLocation event with data: $data');
      // Handle the received data here
      emitUpdateLocationEvent(currentLatitude ?? 0, currentLongitude ??0);
      processUpdateLocationData(data);
    });
  }

  void emitUpdateLocationEvent(num latitude, num longitude) {
    final data = {
      'delegate': delegateInfo!.id,
      'latitude': latitude,
      'longitude': longitude,
    };

    socket.emit('updateLocation', data);
    debugPrint('Sent updateLocation event with data: $data');
  }

  void processUpdateLocationData(dynamic data) {
    // Process the received data here
    debugPrint('Processing updateLocation data: $data');
    // Update your app state or perform any necessary actions
    // based on the received data
  }

}
