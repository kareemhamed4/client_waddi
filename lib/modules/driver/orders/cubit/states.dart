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

class DriverConfirmOrderByAcceptLoadingState extends DriverOrdersStates {}
class DriverConfirmOrderByAcceptSuccessState extends DriverOrdersStates {
  final String msg;
  DriverConfirmOrderByAcceptSuccessState(this.msg);
}
class DriverConfirmOrderByAcceptErrorState extends DriverOrdersStates {
  final String error;
  DriverConfirmOrderByAcceptErrorState(this.error);
}

class DriverConfirmOrderByRejectLoadingState extends DriverOrdersStates {}
class DriverConfirmOrderByRejectSuccessState extends DriverOrdersStates {
  final String msg;
  DriverConfirmOrderByRejectSuccessState(this.msg);
}
class DriverConfirmOrderByRejectErrorState extends DriverOrdersStates {
  final String error;
  DriverConfirmOrderByRejectErrorState(this.error);
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

class UserUIdsLoaded extends DriverOrdersStates {
  final List<String?> userUIds;
  UserUIdsLoaded(this.userUIds);
}
class UserNotFound extends DriverOrdersStates {}
class UserFetchError extends DriverOrdersStates {
  final String error;
  UserFetchError(this.error);
}

class ImagePickedSuccessState extends DriverOrdersStates {}
class ImagePickedErrorState extends DriverOrdersStates {}
class ImageDeletedSuccessState extends DriverOrdersStates {}

class ImageUploadLoadingState extends DriverOrdersStates {}
class ImageUploadSuccessState extends DriverOrdersStates {
  final String msg;

  ImageUploadSuccessState(this.msg);
}
class ImageUploadErrorState extends DriverOrdersStates {
  final String error;
  ImageUploadErrorState(this.error);
}