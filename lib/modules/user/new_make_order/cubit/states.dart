import 'package:waddy_app/models/user/order_details.dart';

abstract class NewMakeOrderStates {}

class NewMakeOrderInitialState extends NewMakeOrderStates {}
class PlusStepperStateState extends NewMakeOrderStates {}
class MinusStepperStateState extends NewMakeOrderStates {}
class ChangeRememberMeState extends NewMakeOrderStates {}
class ChangeCardDataState extends NewMakeOrderStates {}

class MakeOrderLoadingState extends NewMakeOrderStates {}
class MakeOrderSuccessState extends NewMakeOrderStates {
  final OrderDetails orderDetails;
  MakeOrderSuccessState(this.orderDetails);
}
class MakeOrderErrorState extends NewMakeOrderStates {
  final String error;
  MakeOrderErrorState(this.error);
}