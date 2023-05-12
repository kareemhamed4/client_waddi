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