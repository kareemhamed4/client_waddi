abstract class NewRegisterStates{}
class NewRegisterInitialState extends NewRegisterStates{}

class NewRegisterChangeTabBarIndexState extends NewRegisterStates{}
class ChangeCompanyPersonalInformationIconState extends NewRegisterStates{}
class ChangeCompanyInformationIconState extends NewRegisterStates{}
class ChangePasswordSuffixState extends NewRegisterStates{}
class ChangeConfirmPasswordSuffixState extends NewRegisterStates{}

//User SignUp
class UserSignUpLoadingState extends NewRegisterStates {}
class UserSignUpSuccessState extends NewRegisterStates {
  final String status;
  UserSignUpSuccessState(this.status);
}
class UserSignUpErrorState extends NewRegisterStates {
  final String error;
  UserSignUpErrorState(this.error);
}

//user signup with firebase
class SignUpWithFBLoadingState extends NewRegisterStates {}
class SignUpWithFBSuccessState extends NewRegisterStates {}
class SignUpWithFBErrorState extends NewRegisterStates {}

class UserCreateWithFBSuccessState extends NewRegisterStates {}
class UserCreateWithFBErrorState extends NewRegisterStates {
  final String error;

  UserCreateWithFBErrorState(this.error);
}

//Company SignUp
class CompanySignUpLoadingState extends NewRegisterStates {}
class CompanySignUpSuccessState extends NewRegisterStates {
  final String status;
  CompanySignUpSuccessState(this.status);
}
class CompanySignUpErrorState extends NewRegisterStates {
  final String error;
  CompanySignUpErrorState(this.error);
}