abstract class EditPasswordForAuthDriverStates {}

class EditPasswordInitialState extends EditPasswordForAuthDriverStates {}

class EditPasswordLoadingState extends EditPasswordForAuthDriverStates {}
class EditPasswordSuccessState extends EditPasswordForAuthDriverStates {}
class EditPasswordErrorState extends EditPasswordForAuthDriverStates {
  final String error;
  EditPasswordErrorState(this.error);
}