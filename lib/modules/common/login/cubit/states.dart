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

