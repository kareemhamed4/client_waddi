import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';

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

class SendMessageSuccessState extends DriverLayoutStates{}
class SendMessageErrorState extends DriverLayoutStates{}
class ReceiveMessageSuccessState extends DriverLayoutStates {}

class GetUsersWithChatLoadingState extends DriverLayoutStates{}
class GetUsersWithChatSuccessState extends DriverLayoutStates{
  final List<UserModelFB> usersWithChat;
  GetUsersWithChatSuccessState(this.usersWithChat);
}
class GetUsersWithChatErrorState extends DriverLayoutStates{
  final String error;
  GetUsersWithChatErrorState(this.error);
}

class GetAllUsersFromFBLoadingState extends DriverLayoutStates{}
class GetAllUsersFromFBSuccessState extends DriverLayoutStates{}
class GetAllUsersFromFBErrorState extends DriverLayoutStates{
  final String error;
  GetAllUsersFromFBErrorState(this.error);
}

