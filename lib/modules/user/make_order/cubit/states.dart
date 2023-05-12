import 'package:waddy_app/models/user/order_details.dart';

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

class UpdateOrderLoadingState extends MakeOrderStates {}
class UpdateOrderSuccessState extends MakeOrderStates {
  final OrderDetails orderDetails;
  UpdateOrderSuccessState(this.orderDetails);
}
class UpdateOrderErrorState extends MakeOrderStates {
  final String error;
  UpdateOrderErrorState(this.error);
}