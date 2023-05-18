import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waddy_app/models/user/client_login_model.dart';
import 'package:waddy_app/modules/common/login/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class WaddyLoginCubit extends Cubit<WaddyLoginStates> {
  WaddyLoginCubit() : super(WaddyLoginInitialState());

  static WaddyLoginCubit get(context) => BlocProvider.of(context);

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
      userLoginWithFB(email: email,password: password);
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

  bool isRememberMe = false;
  void changeRememberMe(bool isEnable){
    isRememberMe = isEnable;
    emit(ChangeRememberMeState());
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_off_outlined;

  void changeLoginSuffixIcon() {
    isPassword = !isPassword;
    suffixIcon =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(WaddyChangePasswordVisibilityState());
  }

  void userLoginWithFB({
    required String email,
    required String password,
  }) {
    emit(LoginWithFBLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      emit(LoginWithFBSuccessState(value.user!.uid));
    }).catchError((error){
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: myFavColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(LoginWithFBErrorState(error.toString()));
    });
  }
}