import 'package:waddy_app/models/driver/delegate_get_all_orders.dart';
import 'package:waddy_app/models/driver/delegate_get_his_orders_model.dart';
import 'package:waddy_app/models/driver/delegate_get_order_details.dart';

abstract class DriverOrdersStates {}
class DriverOrdersInitialState extends DriverOrdersStates {}
class ChangeTabBarIndexState extends DriverOrdersStates {}

class GetDriverOrdersLoadingState extends DriverOrdersStates {}
class GetDriverOrdersSuccessState extends DriverOrdersStates {
  final DelegateOrders delegateOrders;
  GetDriverOrdersSuccessState(this.delegateOrders);
}
class GetDriverOrdersErrorState extends DriverOrdersStates {
  final String error;
  GetDriverOrdersErrorState(this.error);
}

class GetOrdersRelatedToDelegateLoadingState extends DriverOrdersStates {}
class GetOrdersRelatedToDelegateSuccessState extends DriverOrdersStates {
  final DelegateGetHisOrders delegateGetHisOrders;
  GetOrdersRelatedToDelegateSuccessState(this.delegateGetHisOrders);
}
class GetOrdersRelatedToDelegateErrorState extends DriverOrdersStates {
  final String error;
  GetOrdersRelatedToDelegateErrorState(this.error);
}

class DelegateTakeOrderLoadingState extends DriverOrdersStates {}
class DelegateTakeOrderSuccessState extends DriverOrdersStates {
  final String msg;
  DelegateTakeOrderSuccessState(this.msg);
}
class DelegateTakeOrderErrorState extends DriverOrdersStates {
  final String error;
  DelegateTakeOrderErrorState(this.error);
}
class GetDriverOrderLoadingState extends DriverOrdersStates {}
class GetDriverOrderSuccessState extends DriverOrdersStates {
  final DelegateOrderDetails delegateOrderDetails;
  GetDriverOrderSuccessState(this.delegateOrderDetails);
}
class GetDriverOrderErrorState extends DriverOrdersStates {
  final String error;
  GetDriverOrderErrorState(this.error);
}

class DriverConfirmOrderLoadingState extends DriverOrdersStates {}
class DriverConfirmOrderSuccessState extends DriverOrdersStates {
  final String msg;
  DriverConfirmOrderSuccessState(this.msg);
}
class DriverConfirmOrderErrorState extends DriverOrdersStates {
  final String error;
  DriverConfirmOrderErrorState(this.error);
}

class GetDriverSearchedOrdersLoadingState extends DriverOrdersStates {}
class GetDriverSearchedOrdersSuccessState extends DriverOrdersStates {
  final DelegateOrders delegateOrders;
  GetDriverSearchedOrdersSuccessState(this.delegateOrders);
}
class GetDriverSearchedOrdersErrorState extends DriverOrdersStates {
  final String error;
  GetDriverSearchedOrdersErrorState(this.error);
}

class RejectOrderLoadingState extends DriverOrdersStates {}
class RejectOrderSuccessState extends DriverOrdersStates {}
class RejectOrderErrorState extends DriverOrdersStates {
  final String error;
  RejectOrderErrorState(this.error);
}

class DeliveredOrderLoadingState extends DriverOrdersStates {}
class DeliveredOrderSuccessState extends DriverOrdersStates {}
class DeliveredOrderErrorState extends DriverOrdersStates {
  final String error;
  DeliveredOrderErrorState(this.error);
}