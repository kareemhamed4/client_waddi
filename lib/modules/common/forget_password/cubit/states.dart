abstract class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}
class ForgetPasswordSuccessState extends ForgetPasswordStates {}
class UserSignUpErrorState extends ForgetPasswordStates {
  final String error;
  UserSignUpErrorState(this.error);
}