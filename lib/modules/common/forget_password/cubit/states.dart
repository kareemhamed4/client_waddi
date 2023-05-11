abstract class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}
class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final String status;
  ForgetPasswordSuccessState(this.status);
}
class ForgetPasswordErrorState extends ForgetPasswordStates {
  final String error;
  ForgetPasswordErrorState(this.error);
}