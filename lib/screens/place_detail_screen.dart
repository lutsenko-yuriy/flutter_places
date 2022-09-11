import 'package:flutter/material.dart';
import 'package:flutter_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import 'maps_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  const PlaceDetailScreen({Key? key}) : super(key: key);

  void _openMapScreen(BuildContext context, Place place) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
              readOnly: true,
              initialLocation: place.location,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final place = context.read<GreatPlaces>().findById(id);

    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(place.image,
                fit: BoxFit.cover, width: double.infinity),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            place.location.address!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () => _openMapScreen(context, place),
            child: const Text('View on Map'),
          )
        ],
      ),
    );
  }
}
