import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/otp/cubit/states.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class VerifyOTPCubit extends Cubit<VerifyOTPStates> {
  VerifyOTPCubit() : super(VerifyOTPInitialState());

  static VerifyOTPCubit get(context) => BlocProvider.of(context);

  String? userId;
  void verifyOTP({
    required String email,
    required String otp,
  }) {
    emit(VerifyOTPLoadingState());
    DioHelper.postData(
      url: VERIFYOTP,
      baseUrl: BASEURL,
      data: {
        'email': email,
        'otp': otp,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        final responseData = value.data;
        userId = responseData['userId'];
        emit(VerifyOTPSuccessState(userId!));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(VerifyOTPErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(VerifyOTPErrorState(errorMessage));
        }
      } else {
        // Handle non-DioError cases
        emit(VerifyOTPErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
