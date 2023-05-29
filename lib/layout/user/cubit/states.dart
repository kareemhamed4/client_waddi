import 'package:waddy_app/models/user/get_user_data_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';

abstract class UserLayoutStates{}

class UserInitialState extends UserLayoutStates{}

class ChangeBottomNavBarUserState extends UserLayoutStates{}

class UserNotificationSuccessState extends UserLayoutStates {}

class UserNotificationErrorState extends UserLayoutStates {
  final String error;

  UserNotificationErrorState(this.error);
}

class UserSearchSuccessState extends UserLayoutStates {}

class GetUserInfoLoadingState extends UserLayoutStates {}
class GetUserInfoSuccessState extends UserLayoutStates {
  final UserInfo userInfo;
  GetUserInfoSuccessState(this.userInfo);
}
class GetUserInfoErrorState extends UserLayoutStates {
  final String error;
  GetUserInfoErrorState(this.error);
}

class GetUserFromFBLoadingState extends UserLayoutStates{}
class GetUserFromFBSuccessState extends UserLayoutStates{}
class GetUserFromFBErrorState extends UserLayoutStates{
  final String error;
  GetUserFromFBErrorState(this.error);
}

class SendMessageSuccessState extends UserLayoutStates{}
class SendMessageErrorState extends UserLayoutStates{}
class ReceiveMessageSuccessState extends UserLayoutStates {}

class GetAllUsersFromFBLoadingState extends UserLayoutStates{}
class GetAllUsersFromFBSuccessState extends UserLayoutStates{}
class GetAllUsersFromFBErrorState extends UserLayoutStates{
  final String error;
  GetAllUsersFromFBErrorState(this.error);
}

class GetAllCompaniesFromFBLoadingState extends UserLayoutStates{}
class GetAllCompaniesFromFBSuccessState extends UserLayoutStates{}
class GetAllCompaniesFromFBErrorState extends UserLayoutStates{
  final String error;
  GetAllCompaniesFromFBErrorState(this.error);
}

class GetUsersWithChatLoadingState extends UserLayoutStates{}
class GetUsersWithChatSuccessState extends UserLayoutStates{
  final List<UserModelFB> usersWithChat;
  GetUsersWithChatSuccessState(this.usersWithChat);
}
class GetUsersWithChatErrorState extends UserLayoutStates{
  final String error;
  GetUsersWithChatErrorState(this.error);
}
