import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/driver/edit_password/cubit/states.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/network/end_point.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';

class EditPasswordForAuthDriverCubit extends Cubit<EditPasswordForAuthDriverStates> {
  EditPasswordForAuthDriverCubit() : super(EditPasswordInitialState());

  static EditPasswordForAuthDriverCubit get(context) => BlocProvider.of(context);

  void editPasswordForAuthDriver({
    required String oldPassword,
    required String newPassword,
    required String newConfirmPassword,
  }) {
    emit(EditPasswordLoadingState());
    DioHelper.patchData(
      url: UPDATEPASSWORDAUTHUSER,
      token: driverToken,
      baseUrl: BASEURL,
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'newConfirmPassword': newConfirmPassword,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        emit(EditPasswordSuccessState());
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(EditPasswordErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(EditPasswordErrorState(errorMessage));
        }
      } else {
        // Handle non-DioError cases
        emit(EditPasswordErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
