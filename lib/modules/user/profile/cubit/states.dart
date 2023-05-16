import 'package:waddy_app/models/user/get_user_data_model.dart';

abstract class UserProfileStates {}

class UserProfileInitialState extends UserProfileStates {}

class GetUserInfoLoadingState extends UserProfileStates {}
class GetUserInfoSuccessState extends UserProfileStates {
  final UserInfo userInfo;
  GetUserInfoSuccessState(this.userInfo);
}
class GetUserInfoErrorState extends UserProfileStates {
  final String error;
  GetUserInfoErrorState(this.error);
}

class ProfileImagePickedSuccessState extends UserProfileStates {}

class ProfileImagePickedErrorState extends UserProfileStates {}

class GetUserFromFBLoadingState extends UserProfileStates{}
class GetUserFromFBSuccessState extends UserProfileStates{}
class GetUserFromFBErrorState extends UserProfileStates{
  final String error;
  GetUserFromFBErrorState(this.error);
}

class SendMessageSuccessState extends UserProfileStates{}
class SendMessageErrorState extends UserProfileStates{}
class ReceiveMessageSuccessState extends UserProfileStates {}

class GetAllUsersFromFBLoadingState extends UserProfileStates{}
class GetAllUsersFromFBSuccessState extends UserProfileStates{}
class GetAllUsersFromFBErrorState extends UserProfileStates{
  final String error;
  GetAllUsersFromFBErrorState(this.error);
}

class GetAllCompaniesFromFBLoadingState extends UserProfileStates{}
class GetAllCompaniesFromFBSuccessState extends UserProfileStates{}
class GetAllCompaniesFromFBErrorState extends UserProfileStates{
  final String error;
  GetAllCompaniesFromFBErrorState(this.error);
}