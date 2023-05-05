import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:waddy_app/modules/login/cubit/states.dart';
import 'package:waddy_app/shared/network/local/cache_helper.dart';

class WaddyLoginCubit extends Cubit<WaddyLoginStates> {
  WaddyLoginCubit() : super(WaddyLoginInitialState());
  static WaddyLoginCubit get(context) => BlocProvider.of(context);

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      http.Response response = await http.post(
          Uri.parse(
              'http://localhost:8080/auth/userInfo => For Get User Info '),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == 200) {
          //debugPrint('User Login Success and his data is : $responseData');
          CacheHelper.saveData(
              key: 'token', value: responseData['data']['token']);
          emit(LoginSuccessState());
        } else {
          debugPrint('Failed Login , reason is  : ${responseData['message']}');
          emit(FailedToLoginState(message: responseData['message']));
        }
      }
    } catch (e) {
      emit(FailedToLoginState(message: e.toString()));
    }
  }

  /*WaddyLoginModel? loginModel;

  void userLogin({
    String? email,
    String? password,
    String? otp,
  })
  {
    emit(WaddyLoadingState());
    DioHelper.postData(
      url: Login,
      data: {
        'email':email,
        'password':password,
      },
    ).then((value)
    {
      loginModel = WaddyLoginModel.fromJson(value.data);
      print(loginModel!.message);
      print(loginModel!.status);
      print(loginModel!.data!.token);
      print(value.data);
      emit(WaddyLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(WaddyLoginErrorState(error.toString()));
    });
  }*/

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(WaddyChangePasswordVisibilityState());
  }

  /* TextEditingController otpController = TextEditingController();
   TextEditingController emailController = TextEditingController();
  EmailAuth emailAuth = EmailAuth(sessionName: 'Test Session');

  void verifyOTP()
  {
    emit(WaddyLoadingState());
    bool result = emailAuth.validateOtp(
      recipientMail: otpController.text,
      userOtp: otpController.text,
    );
    if(result)
      {
        print('OTP Verified');
      }else
        {
          print('Invalid OTP');
        }
  }*/
}
