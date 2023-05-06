abstract class DriverLayoutStates{}

class DriverInitialState extends DriverLayoutStates{}

class ChangeBottomNavBarDriverState extends DriverLayoutStates{}

class DriverNotificationSuccessState extends DriverLayoutStates {}

class DriverNotificationErrorState extends DriverLayoutStates {
  final String error;

  DriverNotificationErrorState(this.error);
}

class DriverSearchSuccessState extends DriverLayoutStates {}

