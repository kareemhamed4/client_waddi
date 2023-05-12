import 'package:waddy_app/models/user/get_user_orders.dart';

abstract class GetDriverOrdersStates {}

class GetUserOrdersInitialState extends GetDriverOrdersStates {}

class GetUserOrdersLoadingState extends GetDriverOrdersStates {}
class GetUserOrdersSuccessState extends GetDriverOrdersStates {
  final List<UserOrders> userOrders;
  GetUserOrdersSuccessState(this.userOrders);
}
class GetUserOrdersErrorState extends GetDriverOrdersStates {
  final String error;
  GetUserOrdersErrorState(this.error);
}

class GetDriverSearchedOrdersLoadingState extends GetDriverOrdersStates {}
class GetDriverSearchedOrdersSuccessState extends GetDriverOrdersStates {
  final UserOrders userOrders;
  GetDriverSearchedOrdersSuccessState(this.userOrders);
}
class GetDriverSearchedOrdersErrorState extends GetDriverOrdersStates {
  final String error;
  GetDriverSearchedOrdersErrorState(this.error);
}

class RejectOrderLoadingState extends GetDriverOrdersStates {}
class RejectOrderSuccessState extends GetDriverOrdersStates {}
class RejectOrderErrorState extends GetDriverOrdersStates {
  final String error;
  RejectOrderErrorState(this.error);
}

class DeliveredOrderLoadingState extends GetDriverOrdersStates {}
class DeliveredOrderSuccessState extends GetDriverOrdersStates {}
class DeliveredOrderErrorState extends GetDriverOrdersStates {
  final String error;
  DeliveredOrderErrorState(this.error);
}