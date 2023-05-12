abstract class SendBillStates {}

class SendBillInitialState extends SendBillStates {}

class SendBillLoadingState extends SendBillStates {}
class SendBillSuccessState extends SendBillStates {
  final String billName;
  SendBillSuccessState(this.billName);
}
class SendBillErrorState extends SendBillStates {
  final String error;
  SendBillErrorState(this.error);
}

