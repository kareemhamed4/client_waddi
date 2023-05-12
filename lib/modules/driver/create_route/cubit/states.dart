import 'package:waddy_app/models/user/order_details.dart';

abstract class RouteStates {}

class RouteInitialState extends RouteStates {}

class StartRouteLoadingState extends RouteStates {}
class StartRouteSuccessState extends RouteStates {
  final String msg;
  StartRouteSuccessState(this.msg);
}
class StartRouteErrorState extends RouteStates {
  final String error;
  StartRouteErrorState(this.error);
}

class DeliveredOrderLoadingState extends RouteStates {}
class DeliveredOrderSuccessState extends RouteStates {
  final OrderDetails orderDetails;
  DeliveredOrderSuccessState(this.orderDetails);
}
class DeliveredOrderErrorState extends RouteStates {
  final String error;
  DeliveredOrderErrorState(this.error);
}

class RejectOrderLoadingState extends RouteStates {}
class RejectOrderSuccessState extends RouteStates {
  final OrderDetails orderDetails;
  RejectOrderSuccessState(this.orderDetails);
}
class RejectOrderErrorState extends RouteStates {
  final String error;
  RejectOrderErrorState(this.error);
}

