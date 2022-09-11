import '../models/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyCdAQJrGrDGP53RUF4yuBz0u0MmUvv0Tj8';

class LocationHelper {

  static String _coordinatesString(Location location) => "${location.latitude},${location.longitude}";

  static String generateLocationPreviewImage({required Location location}) {
    final coordinates = _coordinatesString(location);
    return "https://maps.googleapis.com/maps/api/staticmap?center=$coordinates&zoom=16&size=600x600&maptype=roadmap&markers=color:red%7Clabel:A%7C$coordinates&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(Location location) async {
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${_coordinatesString(location)}&key=$GOOGLE_API_KEY";
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body) as Map<String, dynamic>;

    return body['results'][0]["formatted_address"];
  }
}
