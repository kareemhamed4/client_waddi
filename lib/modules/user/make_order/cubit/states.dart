import 'package:waddy_app/models/common/order_details.dart';

abstract class MakeOrderStates {}

class MakeOrderInitialState extends MakeOrderStates {}

class MakeOrderLoadingState extends MakeOrderStates {}
class MakeOrderSuccessState extends MakeOrderStates {
  final OrderDetails orderDetails;
  MakeOrderSuccessState(this.orderDetails);
}
class MakeOrderErrorState extends MakeOrderStates {
  final String error;
  MakeOrderErrorState(this.error);
}