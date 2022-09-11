import 'package:flutter/material.dart';
import 'package:flutter_places/providers/great_places.dart';
import 'package:flutter_places/screens/add_place_screen.dart';
import 'package:flutter_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  void _openAddNewPlaceScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
  }

  void _openPlaceDetailsScreen(BuildContext context, String placeId) {
    Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: placeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
              onPressed: () => _openAddNewPlaceScreen(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future: context.read<GreatPlaces>().fetchAndSetPlaces(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    builder: (context, greatPlaces, child) {
                      return greatPlaces.items.isEmpty
                          ? child!
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                    leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                            greatPlaces.items[i].image)),
                                    title: Text(greatPlaces.items[i].title),
                                    subtitle:
                                        greatPlaces.items[i].location.address != null
                                            ? Text(greatPlaces.items[i].location.address!)
                                            : null,
                                    onTap: () => _openPlaceDetailsScreen(context, greatPlaces.items[i].id),
                                  ));
                    },
                    child: const Center(
                      child: Text("Got no place to show"),
                    ));
          }),
    );
  }
}
