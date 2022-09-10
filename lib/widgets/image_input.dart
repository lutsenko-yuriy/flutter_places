import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;

  const ImageInput({Key? key, required this.onSelectImage})
      : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final imageFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage!.path);
    widget.onSelectImage(await _storedImage!.copy("${appDir.path}/$fileName"));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: _storedImage != null
                  ? Image.file(_storedImage!,
                      fit: BoxFit.cover, width: double.infinity)
                  : const Center(
                      child: Text(
                      "No image taken",
                      textAlign: TextAlign.center,
                    ))),
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton.icon(
          icon: const Icon(Icons.camera),
          style: TextButton.styleFrom(
              textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          )),
          label: const Text(
            'Take a picture',
          ),
          onPressed: _takePicture,
        )
      ],
    );
  }
}
