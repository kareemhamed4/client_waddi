import 'package:waddy_app/models/user/login_model.dart';

abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

//User SignUp
class UserSignUpLoadingState extends SignUpStates {}
class UserSignUpSuccessState extends SignUpStates {
  final LoginModel signup;
  UserSignUpSuccessState(this.signup);
}
class UserSignUpErrorState extends SignUpStates {
  final String error;
  UserSignUpErrorState(this.error);
}

//Driver SignUp
class DriverSignUpLoadingState extends SignUpStates {}
class DriverSignUpSuccessState extends SignUpStates {
  final LoginModel signup;
  DriverSignUpSuccessState(this.signup);
}
class DriverSignUpErrorState extends SignUpStates {
  final String error;
  DriverSignUpErrorState(this.error);
}