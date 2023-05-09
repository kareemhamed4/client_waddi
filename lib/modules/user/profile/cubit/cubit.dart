import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/modules/user/profile/cubit/states.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  static UserProfileCubit get(context) => BlocProvider.of(context);

  UserInfo? userInfo;
  void getUserData() {
    emit(GetUserInfoLoadingState());

    DioHelper.getData(
      url: GETUSERINFO,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      userInfo = UserInfo.fromJson(value.data);
      emit(GetUserInfoSuccessState(userInfo!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetUserInfoErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(GetUserInfoErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(GetUserInfoErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
