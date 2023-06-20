import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waddy_app/cubit/user/cubit.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class MyGoogleMap extends StatefulWidget {
  final bool isGoToMyLocationEnabled;
  final bool isTracking;
  final bool isPlaces;
  final double zoom;
  final List<LatLng>? destinations;
  final LatLng? destination;
  const MyGoogleMap({
    Key? key,
    required this.isGoToMyLocationEnabled,
    required this.isTracking,
    required this.isPlaces,
    this.zoom = 14,
    this.destinations,
    this.destination,
  }) : super(key: key);

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  late bool isGoToMyLocationEnabled;
  late bool isTracking;
  late bool isPlaces;
  double zoom = 14;
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static LatLng sourceLocation = LatLng(currentLocation!.latitude, currentLocation!.longitude);
  List<LatLng> destinations = [];

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    if (currentLocation != null && destinations.isNotEmpty) {
      for (int i = 0; i < destinations.length - 1; i++) {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey,
          PointLatLng(destinations[i].latitude, destinations[i].longitude),
          PointLatLng(destinations[i + 1].latitude, destinations[i + 1].longitude),
        );
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        }
      }
      setState(() {});
    }
  }

  BitmapDescriptor destinationMarkerIcon = BitmapDescriptor.defaultMarker;
  Future<void> addCustomIconForClients() async {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/icons/icontest96.png").then((icon) {
      setState(() {
        destinationMarkerIcon = icon;
      });
    });
  }

  BitmapDescriptor currentMarkerIcon = BitmapDescriptor.defaultMarker;
  Future<void> addCustomIconForDelegate() async {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/icons/myicontest96.png").then((icon) {
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
    darkMapStyleWithoutPlaces = await rootBundle.loadString('assets/map_style/dark_without_landmark_and_places.json');
    lightMapStyleWithoutPlaces = await rootBundle.loadString('assets/map_style/light_without_landmark_and_places.json');
  }

  Future<void> setupMarkers() async {
    await addCustomIconForDelegate();
    await addCustomIconForClients();
    // Add the destination marker
    markers.add(
      Marker(
        markerId: const MarkerId("source"),
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        draggable: true,
        onDragEnd: (value) {},
        icon: currentMarkerIcon,
      ),
    );
    if(widget.destination != null){
      markers.add(
        Marker(
          markerId: const MarkerId("destination"),
          position: LatLng(widget.destination!.latitude, widget.destination!.latitude,),
          draggable: true,
          onDragEnd: (value) {},
          icon: destinationMarkerIcon,
        ),
      );
    }
    if (destinations.isNotEmpty) {
      for (int i = 0; i < destinations.length; i++) {
        markers.add(
          Marker(
            markerId: MarkerId('destination_$i'),
            position: destinations[i],
            draggable: true,
            onDragEnd: (value) {},
            icon: destinationMarkerIcon,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    destinations = widget.destinations != null ? widget.destinations! : [];
    addCustomIconForDelegate();
    addCustomIconForClients();
    loadMapStyles();
    setupMarkers();
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
        markers: markers,
      ),
    );
  }
}
