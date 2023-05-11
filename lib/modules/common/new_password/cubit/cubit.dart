import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/new_password/cubit/states.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordStates> {
  UpdatePasswordCubit() : super(UpdatePasswordInitialState());

  static UpdatePasswordCubit get(context) => BlocProvider.of(context);

  void updatePassword({
    required String userId,
    required String password,
    required String confirmPassword,
  }) {
    emit(UpdatePasswordLoadingState());
    DioHelper.patchData(
      url: UPDATEPASSWORD,
      baseUrl: BASEURL,
      data: {
        'userId': userId,
        'password': password,
        'confirmPassword': confirmPassword,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        emit(UpdatePasswordSuccessState());
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UpdatePasswordErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(UpdatePasswordErrorState(errorMessage));
        }
      } else {
        // Handle non-DioError cases
        emit(UpdatePasswordErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
