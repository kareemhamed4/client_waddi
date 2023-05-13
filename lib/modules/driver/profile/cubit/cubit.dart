import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/modules/driver/profile/cubit/states.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';

class DriverProfileCubit extends Cubit<DriverProfileStates> {
  DriverProfileCubit() : super(DriverProfileInitialState());

  static DriverProfileCubit get(context) => BlocProvider.of(context);

  UserInfo? userInfo;
  void getDriverData() {
    emit(GetDriverInfoLoadingState());

    DioHelper.getData(
      url: GETUSERINFO,
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      userInfo = UserInfo.fromJson(value.data);
      emit(GetDriverInfoSuccessState(userInfo!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetDriverInfoErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(GetDriverInfoErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(GetDriverInfoErrorState('An error occurred. Please try again.'));
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
}
