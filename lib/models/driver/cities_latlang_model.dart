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
];
