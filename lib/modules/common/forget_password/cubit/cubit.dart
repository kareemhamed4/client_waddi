import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/forget_password/cubit/states.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  void forgetPassword({
    required String email,
  }) {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(
      url: FORGETPASSWORD,
      baseUrl: BASEURL,
      data: {
        'email': email,
      },
    ).then((value) {
      if (value.statusCode == 200 &&
          value.data.toString().contains("OK")) {
        emit(ForgetPasswordSuccessState(value.data.toString()));
      } else {
        emit(ForgetPasswordErrorState('An error occurred. Please try again.'));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(ForgetPasswordErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(ForgetPasswordErrorState(errorMessage));
        }
      } else {
        // Handle non-DioError cases
        emit(ForgetPasswordErrorState('An error occurred. Please try again.'));
      }
    });
  }
}