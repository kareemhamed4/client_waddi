import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/driver/cubit/states.dart';
import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/driver/home/home_screen.dart';
import 'package:waddy_app/modules/driver/inbox/inbox_screen.dart';
import 'package:waddy_app/modules/driver/orders/orders_screen.dart';
import 'package:waddy_app/modules/driver/profile/profile_screen.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';

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
  void getDelegateDataFromFB() async {
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
}
