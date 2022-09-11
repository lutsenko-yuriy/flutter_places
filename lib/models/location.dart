import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final double latitude;
  final double longitude;
  final String? address;

  const Location(
      {required this.latitude, required this.longitude, this.address});

  factory Location.fromLatLng(LatLng position) {
    return Location(
      latitude: position.latitude,
      longitude: position.longitude
    );
  }

  factory Location.fromAnotherLocationWithAddress(Location location, String address) {
    return Location(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address
    );
  }
}
