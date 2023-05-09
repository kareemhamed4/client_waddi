abstract class UserTrackingStates {}

class UserTrackingInitialState extends UserTrackingStates {}

class UserTrackingLoadingState extends UserTrackingStates {}
class UserTrackingSuccessState extends UserTrackingStates {}
class UserTrackingErrorState extends UserTrackingStates {
  final String error;
  UserTrackingErrorState(this.error);
}