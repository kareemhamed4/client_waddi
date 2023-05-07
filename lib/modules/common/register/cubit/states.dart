abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class UserSignUpLoadingState extends SignUpStates {}
class UserSignUpSuccessState extends SignUpStates {}
class UserSignUpErrorState extends SignUpStates {}

class DriverSignUpLoadingState extends SignUpStates {}
class DriverSignUpSuccessState extends SignUpStates {}
class DriverSignUpErrorState extends SignUpStates {}

class UserCreateSuccessState extends SignUpStates {}
class UserCreateErrorState extends SignUpStates {
  final String error;

  UserCreateErrorState(this.error);
}