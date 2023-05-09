abstract class EditPasswordForAuthUserStates {}

class EditPasswordInitialState extends EditPasswordForAuthUserStates {}

class EditPasswordLoadingState extends EditPasswordForAuthUserStates {}
class EditPasswordSuccessState extends EditPasswordForAuthUserStates {}
class EditPasswordErrorState extends EditPasswordForAuthUserStates {
  final String error;
  EditPasswordErrorState(this.error);
}