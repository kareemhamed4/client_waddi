abstract class UpdatePasswordStates {}

class UpdatePasswordInitialState extends UpdatePasswordStates {}

class UpdatePasswordLoadingState extends UpdatePasswordStates {}
class UpdatePasswordSuccessState extends UpdatePasswordStates {}
class UpdatePasswordErrorState extends UpdatePasswordStates {
  final String error;
  UpdatePasswordErrorState(this.error);
}