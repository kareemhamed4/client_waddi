// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class searchData extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {}, icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('No Result'));
  }
}

double? deviceWidth;
const String googleApiKey = "AIzaSyDUNaxTG6FDCGz51xE-Uc9ZoEAbHsawv8M";
Position? currentLocation;
String? currentLocationAsString;
num? currentLatitude = currentLocation != null ? currentLocation!.latitude : 0;
num? currentLongitude = currentLocation != null ? currentLocation!.longitude : 0;
double distance = 0;
String? userToken = '';
String? driverToken = '';
String? uId = '';
