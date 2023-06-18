import 'dart:math';

import 'package:flutter/material.dart';
import 'package:waddy_app/models/driver/cities_latlang_model.dart';

List<int> tspRoute = [];
Future<List<int>> tspNearestNeighbor(List<CitiesLatLong> locations) async{
  tspRoute.clear();
  final int numLocations = locations.length;

  // Choose a random starting location
  final Random random = Random();
  int currentLocationIndex = random.nextInt(numLocations);
  tspRoute.add(currentLocationIndex);

  // Create a set to keep track of visited locations
  final Set<int> visitedLocations = {currentLocationIndex};

  while (visitedLocations.length < numLocations) {
    double minDistance = double.infinity;
    int nearestLocationIndex = -1;

    // Find the nearest unvisited location
    for (int i = 0; i < numLocations; i++) {
      if (!visitedLocations.contains(i)) {
        final double distance = calculateDistance(
            locations[currentLocationIndex], locations[i]);
        if (distance < minDistance) {
          minDistance = distance;
          nearestLocationIndex = i;
        }
      }
    }

    // Add the nearest location to the TSP route
    tspRoute.add(nearestLocationIndex);
    visitedLocations.add(nearestLocationIndex);
    currentLocationIndex = nearestLocationIndex;
  }
  debugPrint(tspRoute.toString());
  return tspRoute;
}

double calculateDistance(CitiesLatLong location1, CitiesLatLong location2) {
  final double lat1 = location1.cityLat;
  final double lon1 = location1.cityLong;
  final double lat2 = location2.cityLat;
  final double lon2 = location2.cityLong;

  const double earthRadius = 6371; // Earth's radius in kilometers

  final double dLat = radians(lat2 - lat1);
  final double dLon = radians(lon2 - lon1);

  final double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(radians(lat1)) * cos(radians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  final double distance = earthRadius * c;
  return distance;
}

double radians(double degrees) {
  return degrees * pi / 180;
}
