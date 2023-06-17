import 'dart:math';

import 'package:flutter/material.dart';

class Location {
  final int id;
  final double latitude;
  final double longitude;

  Location(this.id, this.latitude, this.longitude);
}

List<int> tspNearestNeighbor(List<Location> locations) {
  final int numLocations = locations.length;
  final List<int> tspRoute = [];

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

double calculateDistance(Location location1, Location location2) {
  final double lat1 = location1.latitude;
  final double lon1 = location1.longitude;
  final double lat2 = location2.latitude;
  final double lon2 = location2.longitude;

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
