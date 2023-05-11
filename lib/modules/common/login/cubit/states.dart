import 'package:waddy_app/models/common/login_model.dart';

abstract class WaddyLoginStates {}

class WaddyLoginInitialState extends WaddyLoginStates{}
class WaddyChangePasswordVisibilityState extends WaddyLoginStates{}

// user login
class UserLoginLoadingState extends WaddyLoginStates {}
class UserLoginSuccessState extends WaddyLoginStates {
  final LoginModel loginModel;
  UserLoginSuccessState(this.loginModel);
}
class UserLoginErrorState extends WaddyLoginStates {
  final String error;
  UserLoginErrorState(this.error);
}
