import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/models/user/order_details.dart';

abstract class GetUserOrdersStates {}

class GetUserOrdersInitialState extends GetUserOrdersStates {}

class GetUserOrdersLoadingState extends GetUserOrdersStates {}
class GetUserOrdersSuccessState extends GetUserOrdersStates {
  final List<UserOrders> userOrders;
  GetUserOrdersSuccessState(this.userOrders);
}
class GetUserOrdersErrorState extends GetUserOrdersStates {
  final String error;
  GetUserOrdersErrorState(this.error);
}

class GetUserSearchedOrdersLoadingState extends GetUserOrdersStates {}
class GetUserSearchedOrdersSuccessState extends GetUserOrdersStates {
  final UserOrders userOrders;
  GetUserSearchedOrdersSuccessState(this.userOrders);
}
class GetUserSearchedOrdersErrorState extends GetUserOrdersStates {
  final String error;
  GetUserSearchedOrdersErrorState(this.error);
}

class DeleteOrderLoadingState extends GetUserOrdersStates {}
class DeleteOrderSuccessState extends GetUserOrdersStates {}
class DeleteOrderErrorState extends GetUserOrdersStates {
  final String error;
  DeleteOrderErrorState(this.error);
}