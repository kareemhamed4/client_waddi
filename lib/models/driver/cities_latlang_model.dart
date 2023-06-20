import 'package:google_maps_flutter/google_maps_flutter.dart';

class CitiesLatLong {
  final String cityName;
  final double cityLat;
  final double cityLong;
  CitiesLatLong({
    required this.cityName,
    required this.cityLat,
    required this.cityLong,
  });
}

List<CitiesLatLong> citiesLatLong = [
  CitiesLatLong(
    cityName: "Benha",
    cityLat: 30.4660,
    cityLong: 31.1848,
  ),
  CitiesLatLong(
    cityName: "Cairo",
    cityLat: 30.0444,
    cityLong: 31.2357,
  ),
  CitiesLatLong(
    cityName: "Tanta",
    cityLat: 30.7865,
    cityLong: 31.0004,
  ),
  CitiesLatLong(
    cityName: "italy",
    cityLat: 41.8719,
    cityLong: 12.5674,
  ),
  CitiesLatLong(
    cityName: "Germany",
    cityLat: 51.1657,
    cityLong: 10.4515,
  ),
  CitiesLatLong(
    cityName: "Kafr kela elbab gharbia",
    cityLat: 30.6858,
    cityLong: 31.1450,
  ),
  CitiesLatLong(
    cityName: "Alexandria",
    cityLat: 31.200594477167297,
    cityLong: 29.9191836197526,
  ),
  CitiesLatLong(
    cityName: "التحرير",
    cityLat: 30.044612917780256,
    cityLong: 31.236190890814655,
  ),
];

List<LatLng> destinationLatLong = const [
  LatLng(30.4660, 31.1848),
  LatLng(30.0444, 31.2357),
  LatLng(30.7865, 31.0004),
  LatLng(41.8719, 12.5674),
  LatLng(51.1657, 10.4515),
  LatLng(30.6858, 31.1450),
  LatLng(31.200594477167297, 29.9191836197526),
  LatLng(30.044612917780256, 31.236190890814655),
];
