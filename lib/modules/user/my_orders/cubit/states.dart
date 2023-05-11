import 'package:waddy_app/models/user/get_user_orders.dart';

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


class UpdateOrderLoadingState extends GetUserOrdersStates {}
class UpdateOrderSuccessState extends GetUserOrdersStates {
  final UserOrders userOrders;
  UpdateOrderSuccessState(this.userOrders);
}
class UpdateOrderErrorState extends GetUserOrdersStates {
  final String error;
  UpdateOrderErrorState(this.error);
}

class DeleteOrderLoadingState extends GetUserOrdersStates {}
class DeleteOrderSuccessState extends GetUserOrdersStates {}
class DeleteOrderErrorState extends GetUserOrdersStates {
  final String error;
  DeleteOrderErrorState(this.error);
}