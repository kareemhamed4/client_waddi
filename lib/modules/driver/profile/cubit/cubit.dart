import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/modules/driver/profile/cubit/states.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/end_point.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';

class DriverProfileCubit extends Cubit<DriverProfileStates> {
  DriverProfileCubit() : super(DriverProfileInitialState());

  static DriverProfileCubit get(context) => BlocProvider.of(context);

  UserInfo? userInfo;
  void getDriverData() {
    emit(GetDriverInfoLoadingState());

    DioHelper.getData(
      url: GETUSERINFO,
      baseUrl: BASEURL,
      token: driverToken,
    ).then((value) {
      userInfo = UserInfo.fromJson(value.data);
      emit(GetDriverInfoSuccessState(userInfo!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData['msg'];
          emit(GetDriverInfoErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(GetDriverInfoErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(GetDriverInfoErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
