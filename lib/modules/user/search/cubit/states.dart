import 'package:waddy_app/models/user/get_user_orders.dart';

abstract class UserSearchOrderStates {}

class UserSearchOrderInitialState extends UserSearchOrderStates {}

class UserSearchOrderIdLoadingState extends UserSearchOrderStates {}
class UserSearchOrderIdSuccessState extends UserSearchOrderStates {
  final UserOrders userOrders;
  UserSearchOrderIdSuccessState(this.userOrders);
}
class UserSearchOrderIdNotFoundState extends UserSearchOrderStates {
  final String msg;
  UserSearchOrderIdNotFoundState(this.msg);
}
class UserSearchOrderIdErrorState extends UserSearchOrderStates {
  final String error;
  UserSearchOrderIdErrorState(this.error);
}


class UserSearchTrackIdLoadingState extends UserSearchOrderStates {}
class UserSearchTrackIdSuccessState extends UserSearchOrderStates {
  final UserOrders userOrders;
  UserSearchTrackIdSuccessState(this.userOrders);
}
class UserSearchTrackIdNotFoundState extends UserSearchOrderStates {
  final String msg;
  UserSearchTrackIdNotFoundState(this.msg);
}
class UserSearchTrackIdErrorState extends UserSearchOrderStates {
  final String error;
  UserSearchTrackIdErrorState(this.error);
}