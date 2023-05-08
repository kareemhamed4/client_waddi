import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/login_model.dart';
import 'package:waddy_app/modules/user/login/cubit/states.dart';
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

  LoginModel? loginModel;

  void userModel({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      baseUrl: BASEURL,
      data: {'email': email, 'password': password},
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState());
    });
  }
}
