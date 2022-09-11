import 'package:flutter/material.dart';
import 'package:flutter_places/helpers/location_helper.dart';
import 'package:location/location.dart' as location;

import '../models/location.dart' as model;

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  model.Location? _location;
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await location.Location().getLocation();

    var locationModel = model.Location(
        latitude: locData.latitude!, longitude: locData.longitude!);

    setState(() {
      _location = locationModel;
      _previewImageUrl =
          LocationHelper.generateLocationPreviewImage(location: locationModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? const Center(child: Text('No location selected so far'))
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
              style: TextButton.styleFrom(
                  textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              )),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              style: TextButton.styleFrom(
                  textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              )),
            )
          ],
        )
      ],
    );
  }
}
