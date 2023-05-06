abstract class UserLayoutStates{}

class UserInitialState extends UserLayoutStates{}

class ChangeBottomNavBarUserState extends UserLayoutStates{}

class UserNotificationSuccessState extends UserLayoutStates {}

class UserNotificationErrorState extends UserLayoutStates {
  final String error;

  UserNotificationErrorState(this.error);
}

class UserSearchSuccessState extends UserLayoutStates {}

