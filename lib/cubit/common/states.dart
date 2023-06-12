abstract class MainStates {}
class MainAppInitialStates extends MainStates {}
class UserUIdsLoaded extends MainStates {
  final List<String?> userUIds;
  UserUIdsLoaded(this.userUIds);
}
class UserNotFound extends MainStates {}
class UserFetchError extends MainStates {
  final String error;
  UserFetchError(this.error);
}
