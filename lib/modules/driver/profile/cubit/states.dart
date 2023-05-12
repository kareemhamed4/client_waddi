import 'package:waddy_app/models/user/get_user_data_model.dart';

abstract class DriverProfileStates {}

class DriverProfileInitialState extends DriverProfileStates {}

class GetDriverInfoLoadingState extends DriverProfileStates {}
class GetDriverInfoSuccessState extends DriverProfileStates {
  final UserInfo userInfo;
  GetDriverInfoSuccessState(this.userInfo);
}
class GetDriverInfoErrorState extends DriverProfileStates {
  final String error;
  GetDriverInfoErrorState(this.error);
}