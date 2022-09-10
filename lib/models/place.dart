import 'dart:io';

import 'package:uuid/uuid.dart';

import 'location.dart';

class Place {
  final String id;
  final String title;
  final Location location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});

  factory Place.withIdGenerated(
      {required String title,
      required Location location,
      required File image}) {
    return Place(
        id: PlaceIdGenerator.getNextId(),
        title: title,
        location: location,
        image: image);
  }
}

class PlaceIdGenerator {
  static String getNextId() {
    return const Uuid().v4();
  }
}
