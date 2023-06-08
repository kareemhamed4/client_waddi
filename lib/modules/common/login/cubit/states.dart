import 'package:waddy_app/models/user/client_login_model.dart';

abstract class WaddyLoginStates {}

class WaddyLoginInitialState extends WaddyLoginStates{}
class WaddyChangePasswordVisibilityState extends WaddyLoginStates{}

// user login
class UserLoginLoadingState extends WaddyLoginStates {}
class UserLoginSuccessState extends WaddyLoginStates {
  final ClientModel clientModel;
  UserLoginSuccessState(this.clientModel);
}
class UserLoginErrorState extends WaddyLoginStates {
  final String error;
  UserLoginErrorState(this.error);
}

class ChangeRememberMeState extends WaddyLoginStates {}

class LoginWithFBLoadingState extends WaddyLoginStates {}
class LoginWithFBSuccessState extends WaddyLoginStates {
  final String uId;

  LoginWithFBSuccessState(this.uId);
}
class LoginWithFBErrorState extends WaddyLoginStates {
  final String error;
  LoginWithFBErrorState(this.error);
}

//delegate signup with firebase
class DelegateSignUpWithFBLoadingState extends WaddyLoginStates {}
class DelegateSignUpWithFBSuccessState extends WaddyLoginStates {}
class DelegateSignUpWithFBErrorState extends WaddyLoginStates {}

class DelegateCreateWithFBSuccessState extends WaddyLoginStates {}
class DelegateCreateWithFBErrorState extends WaddyLoginStates {
  final String error;

  DelegateCreateWithFBErrorState(this.error);
}

