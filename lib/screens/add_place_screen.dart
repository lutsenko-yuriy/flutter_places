import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();

  void _onPlaceSaved() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New place")),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        const SizedBox(height: 10,),
                        const ImageInput()
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add place'),
                onPressed: _onPlaceSaved,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                )
              ),
            ]
        )
    );
  }
}
