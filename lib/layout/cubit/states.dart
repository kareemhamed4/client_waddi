abstract class ShippingStates{}

class ShippingInitialState extends ShippingStates{}

class ChangeBottomNavBar extends ShippingStates{}

class ShippingNotificationSuccessState extends ShippingStates {}

class ShippingNotificationErrorState extends ShippingStates {
  final String error;

  ShippingNotificationErrorState(this.error);
}

class ShippingSearchSuccessState extends ShippingStates {}

