import 'package:waddy_app/models/user/client_login_model.dart';

abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

//User SignUp
class UserSignUpLoadingState extends SignUpStates {}
class UserSignUpSuccessState extends SignUpStates {
  final String status;
  UserSignUpSuccessState(this.status);
}
class UserSignUpErrorState extends SignUpStates {
  final String error;
  UserSignUpErrorState(this.error);
}

//Driver SignUp
class CompanySignUpLoadingState extends SignUpStates {}
class CompanySignUpSuccessState extends SignUpStates {
  final String status;
  CompanySignUpSuccessState(this.status);
}
class CompanySignUpErrorState extends SignUpStates {
  final String error;
  CompanySignUpErrorState(this.error);
}