import '../models/location.dart';

const GOOGLE_API_KEY = 'AIzaSyCdAQJrGrDGP53RUF4yuBz0u0MmUvv0Tj8';

class LocationHelper {
  static String generateLocationPreviewImage({required Location location}) {
    final coordinates = "${location.latitude},${location.longitude}";
    return "https://maps.googleapis.com/maps/api/staticmap?center=$coordinates&zoom=16&size=600x600&maptype=roadmap&markers=color:red%7Clabel:A%7C$coordinates&key=$GOOGLE_API_KEY";
  }
}
