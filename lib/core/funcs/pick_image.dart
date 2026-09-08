 import 'package:avora/core/di/dependecny_injection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final _imagePicker = getIt<ImagePicker>();
Future<XFile?> pickImage(BuildContext context) async {
  final image = await _imagePicker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 90,
  );

  if (image == null) {
    return null ;
  }



  final extension = image.path.split('.').last.toLowerCase();

  const supportedExtensions = {
    'jpg',
    'jpeg',
    'png',
    'webp',
  };

  if (!supportedExtensions.contains(extension)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select a JPG, PNG, or WebP image.'),
      ),
    );

    return null;
  }

  return image;

}