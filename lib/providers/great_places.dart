import 'package:flutter/cupertino.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {

  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(Place place) {
    _items.add(place);
    notifyListeners();
  }
}