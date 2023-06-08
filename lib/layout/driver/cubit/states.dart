import 'package:waddy_app/models/user/get_user_data_model.dart';

abstract class DriverLayoutStates{}

class DriverInitialState extends DriverLayoutStates{}
class ChangeBottomNavBarDriverState extends DriverLayoutStates{}
class DriverNotificationSuccessState extends DriverLayoutStates {}
class DriverNotificationErrorState extends DriverLayoutStates {
  final String error;
  DriverNotificationErrorState(this.error);
}
class DriverSearchSuccessState extends DriverLayoutStates {}

class GetDelegateInfoLoadingState extends DriverLayoutStates {}
class GetDelegateInfoSuccessState extends DriverLayoutStates {
  final UserInfo delegateInfo;
  GetDelegateInfoSuccessState(this.delegateInfo);
}
class GetDelegateInfoErrorState extends DriverLayoutStates {
  final String error;
  GetDelegateInfoErrorState(this.error);
}

class GetDelegateFromFBLoadingState extends DriverLayoutStates{}
class GetDelegateFromFBSuccessState extends DriverLayoutStates{}
class GetDelegateFromFBErrorState extends DriverLayoutStates{
  final String error;
  GetDelegateFromFBErrorState(this.error);
}

