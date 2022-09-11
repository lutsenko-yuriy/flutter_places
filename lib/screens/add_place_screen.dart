import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_places/helpers/location_helper.dart';
import 'package:flutter_places/models/location.dart';
import 'package:flutter_places/providers/great_places.dart';
import 'package:flutter_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File? _pickedImage;

  Location? _location;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  Future<void> _selectLocation(Location location) async {
    _location = location;
  }

  Future<void> _savePlace() async {
    final title = _titleController.text;
    final image = _pickedImage;
    final location = _location;

    if (title.isEmpty || image == null || location == null) {
      return;
    }

    context.read<GreatPlaces>().addPlace(Place.withIdGenerated(
        title: title,
        image: image,
        location: Location.fromAnotherLocationWithAddress(
            location, await LocationHelper.getPlaceAddress(location))));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New place")),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(onSelectImage: _selectImage),
                    const SizedBox(
                      height: 10,
                    ),
                    LocationInput(onLocationUpdated: _selectLocation)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
              onPressed: _savePlace,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )),
        ]));
  }
}
