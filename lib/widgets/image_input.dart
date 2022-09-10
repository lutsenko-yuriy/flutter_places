import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

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
          onPressed: () {},
        )      ],
    );
  }
}
