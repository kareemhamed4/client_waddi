import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/client_login_model.dart';
import 'package:waddy_app/modules/common/login/cubit/states.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class WaddyLoginCubit extends Cubit<WaddyLoginStates> {
  WaddyLoginCubit() : super(WaddyLoginInitialState());

  static WaddyLoginCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(WaddyChangePasswordVisibilityState());
  }

  ClientModel? clientModel;

  Future<void> userLogin({
    required String email,
    required String password,
  }) async{
    emit(UserLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      baseUrl: BASEURL,
      data: {'email': email, 'password': password},
    ).then((value) {
      clientModel = ClientModel.fromJson(value.data);
      emit(UserLoginSuccessState(clientModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UserLoginErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(UserLoginErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(UserLoginErrorState('An error occurred. Please try again.'));
      }
    });
  }
}