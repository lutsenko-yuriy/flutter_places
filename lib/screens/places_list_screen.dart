import 'package:flutter/material.dart';
import 'package:flutter_places/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  void _openAddNewPlaceScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
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
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
