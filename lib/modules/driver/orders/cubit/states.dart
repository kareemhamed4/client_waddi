import 'package:waddy_app/models/user/get_user_orders.dart';

abstract class GetDriverOrdersStates {}

class GetDriverOrdersInitialState extends GetDriverOrdersStates {}

class GetDriverOrdersLoadingState extends GetDriverOrdersStates {}
class GetDriverOrdersSuccessState extends GetDriverOrdersStates {
  final List<UserOrders> userOrders;
  GetDriverOrdersSuccessState(this.userOrders);
}
class GetDriverOrdersErrorState extends GetDriverOrdersStates {
  final String error;
  GetDriverOrdersErrorState(this.error);
}

class GetDriverOrderLoadingState extends GetDriverOrdersStates {}
class GetDriverOrderSuccessState extends GetDriverOrdersStates {
  final UserOrders userOrder;
  GetDriverOrderSuccessState(this.userOrder);
}
class GetDriverOrderErrorState extends GetDriverOrdersStates {
  final String error;
  GetDriverOrderErrorState(this.error);
}

class DriverConfirmOrderLoadingState extends GetDriverOrdersStates {}
class DriverConfirmOrderSuccessState extends GetDriverOrdersStates {
  final String msg;
  DriverConfirmOrderSuccessState(this.msg);
}
class DriverConfirmOrderErrorState extends GetDriverOrdersStates {
  final String error;
  DriverConfirmOrderErrorState(this.error);
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