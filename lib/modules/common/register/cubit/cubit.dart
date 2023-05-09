import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/login_model.dart';
import 'package:waddy_app/modules/common/register/cubit/states.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  LoginModel? signupModel;
  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String address,
  }) {
    emit(UserSignUpLoadingState());
    DioHelper.postData(
      url: USERREGISTER,
      baseUrl: BASEURL,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phone': phone,
        'address': address,
      },
    ).then((value) {
      signupModel = LoginModel.fromJson(value.data);
      emit(UserSignUpSuccessState(signupModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UserSignUpErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(UserSignUpErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(UserSignUpErrorState('An error occurred. Please try again.'));
      }
    });
  }

  void driverRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String companyName,
    required String industry,
    required String phone,
    required String governorate,
    required String postalcode,
  }) {
    emit(UserSignUpLoadingState());
    DioHelper.postData(
      url: DRIVERREGISTER,
      baseUrl: BASEURL,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'companyName': companyName,
        'industry': industry,
        'phone': phone,
        'governorate': governorate,
        'postalcode': postalcode,
      },
    ).then((value) {
      signupModel = LoginModel.fromJson(value.data);
      emit(DriverSignUpSuccessState(signupModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(DriverSignUpErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(DriverSignUpErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(DriverSignUpErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
