import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waddy_app/cubit/user/cubit.dart';
import 'package:waddy_app/shared/components/constants.dart';

class MyGoogleMap extends StatefulWidget {
  final bool isGoToMyLocationEnabled;
  final bool isTracking;
  final bool isPlaces;
  final double zoom;
  const MyGoogleMap({
    Key? key,
    required this.isGoToMyLocationEnabled,
    required this.isTracking,
    required this.isPlaces,
    this.zoom = 14,
  }) : super(key: key);

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  late bool isGoToMyLocationEnabled;
  late bool isTracking;
  late bool isPlaces;
  double zoom = 14;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static LatLng sourceLocation =
      LatLng(currentLocation!.latitude, currentLocation!.longitude);
  static const LatLng destination = LatLng(30.7924168532, 30.9987951871);

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    if (currentLocation != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {});
      }
    }
  }

  BitmapDescriptor destinationMarkerIcon = BitmapDescriptor.defaultMarker;
  void addCustomIconForPatient() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/destination.png")
        .then((icon) {
      setState(() {
        destinationMarkerIcon = icon;
      });
    });
  }

  BitmapDescriptor currentMarkerIcon = BitmapDescriptor.defaultMarker;
  void addCustomIconForAmbulance() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons/current.png")
        .then((icon) {
      setState(() {
        currentMarkerIcon = icon;
      });
    });
  }

  String? darkMapStyle;
  String? lightMapStyle;
  String? darkMapStyleWithoutPlaces;
  String? lightMapStyleWithoutPlaces;
  Future loadMapStyles() async {
    darkMapStyle = await rootBundle.loadString('assets/map_style/night.json');
    lightMapStyle = await rootBundle.loadString('assets/map_style/light.json');
    darkMapStyleWithoutPlaces = await rootBundle
        .loadString('assets/map_style/dark_without_landmark_and_places.json');
    lightMapStyleWithoutPlaces = await rootBundle
        .loadString('assets/map_style/light_without_landmark_and_places.json');
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return distance = double.parse((12742 * asin(sqrt(a))).toStringAsFixed(2));
  }

  @override
  void initState() {
    loadMapStyles();
    calculateDistance(sourceLocation.latitude, sourceLocation.longitude,
        destination.latitude, destination.longitude);
    debugPrint(distance.toString());
    addCustomIconForAmbulance();
    addCustomIconForPatient();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isGoToMyLocationEnabled = widget.isGoToMyLocationEnabled;
    isTracking = widget.isTracking;
    zoom = widget.zoom;
    return SizedBox(
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: isGoToMyLocationEnabled,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: zoom,
          bearing: 0.0,
          tilt: 0.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          controller.setMapStyle((UserCubit.get(context).isDark && isPlaces)
              ? darkMapStyle
              : (UserCubit.get(context).isDark && !isPlaces)
                  ? darkMapStyleWithoutPlaces
                  : (!UserCubit.get(context).isDark && isPlaces)
                      ? lightMapStyle
                      : lightMapStyleWithoutPlaces);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
          ),
        },
        markers: {
          Marker(
              markerId: const MarkerId("source"),
              position: destination,
              draggable: true,
              onDragEnd: (value) {},
              icon: destinationMarkerIcon),
          if (isTracking)
            Marker(
              markerId: const MarkerId("destination"),
              position: sourceLocation,
              draggable: true,
              onDragEnd: (value) {},
              icon: currentMarkerIcon,
            ),
        },
      ),
    );
  }
}
