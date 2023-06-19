import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waddy_app/cubit/common/states.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainAppInitialStates());

  static MainCubit get(context) => BlocProvider.of(context);

  StreamSubscription<Position>? _positionStreamSubscription;

  void startLocationUpdates() {
    emit(UpdateLocationLoadingState());
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Minimum distance (in meters) before receiving updates
      ),
    ).listen((Position position) {
      // Call the update method with the new latitude and longitude values
      if (uId != null) {
        updateLocationInFirebase(position.latitude, position.longitude);
      }
    });
  }

  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  void updateLocationInFirebase(double latitude, double longitude) {
    FirebaseFirestore.instance.collection(userToken != null ? 'Users' : 'Delegates').doc(uId).update({
      'latitude': latitude,
      'longitude': longitude,
    }).then((value) {
      emit(UpdateLocationSuccessState(latitude: latitude, longitude: longitude));
    }).catchError((error) {
      emit(UpdateLocationErrorState(error.toString()));
    });
  }

  void sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'kareemhamed818@gmail.com',
      queryParameters: {
        'subject': 'Test Subject :: 😀 :: ${DateTime.now()}',
        'body': 'Test Body',
      },
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }
}
