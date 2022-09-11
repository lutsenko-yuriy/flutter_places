import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../helpers/db_helpers.dart';
import '../models/location.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(Place place) {
    _items.add(place);
    notifyListeners();
    DBHelper.insert('places',
        {
          'id': place.id,
          'title': place.title,
          'image': place.image.path,
          'loc_lat': place.location.latitude,
          'loc_lng': place.location.longitude,
          'address': place.location.address ?? ""
        });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData('places');
    final places = data
        .map((e) =>
        Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: Location(
              latitude: e['loc_lat'],
              longitude: e['loc_lng'],
              address: e['address']
            )))
        .toList();

    _items.clear();
    _items.addAll(places);

    notifyListeners();
  }
}
