import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/edit_password/cubit/states.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class EditPasswordForAuthUserCubit extends Cubit<EditPasswordForAuthUserStates> {
  EditPasswordForAuthUserCubit() : super(EditPasswordInitialState());

  static EditPasswordForAuthUserCubit get(context) => BlocProvider.of(context);

  void editPasswordForAuthUser({
    required String oldPassword,
    required String newPassword,
    required String newConfirmPassword,
  }) {
    emit(EditPasswordLoadingState());
    DioHelper.patchData(
      url: UPDATEPASSWORDAUTHUSER,
      token: userToken,
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
          emit(EditPasswordErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(EditPasswordErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
