abstract class VerifyOTPStates {}

class VerifyOTPInitialState extends VerifyOTPStates {}

class VerifyOTPLoadingState extends VerifyOTPStates {}
class VerifyOTPSuccessState extends VerifyOTPStates {
  final String userId;
  VerifyOTPSuccessState(this.userId);
}
class VerifyOTPErrorState extends VerifyOTPStates {
  final String error;
  VerifyOTPErrorState(this.error);
}