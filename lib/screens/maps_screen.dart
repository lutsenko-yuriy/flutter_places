import 'package:flutter/material.dart';
import '../models/location.dart' as model;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final model.Location? initialLocation;
  final bool readOnly;

  const MapScreen(
      {Key? key,
      this.initialLocation,
      this.readOnly = false})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  model.Location? _pickedLocation;

  @override
  void initState() {
    _pickedLocation = widget.initialLocation;
    super.initState();
  }

  void _savePosition() {
    Navigator.of(context).pop(_pickedLocation);
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedLocation = model.Location.fromLatLng(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    final initialLocation = _pickedLocation ?? const model.Location(latitude: 37.422131, longitude: -122.084801);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: [
          if (!widget.readOnly && _pickedLocation != null)
            IconButton(onPressed: _savePosition, icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(initialLocation.latitude,
                initialLocation.longitude),
            zoom: 16),
        onTap: widget.readOnly ? null : (latLng) => _selectPosition(latLng),
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'),
                    position: LatLng(
                        _pickedLocation!.latitude, _pickedLocation!.longitude))
              },
      ),
    );
  }
}
