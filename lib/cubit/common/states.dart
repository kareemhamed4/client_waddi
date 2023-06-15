abstract class MainStates {}
class MainAppInitialStates extends MainStates {}
class UpdateLocationLoadingState extends MainStates {}

class UpdateLocationSuccessState extends MainStates {
  final double latitude,longitude;
  UpdateLocationSuccessState({required this.latitude, required this.longitude});
}
class UpdateLocationErrorState extends MainStates {
  final String error;
  UpdateLocationErrorState(this.error);
}
