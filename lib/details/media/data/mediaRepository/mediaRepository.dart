import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MediaRepository {
  Future<String> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return "";

      print(image.path);
      return image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return "";
    }
  }

  Future<String> pickVideo() async {
    try {
      final image = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (image == null) return "";

      print(image.path);
      return image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return "";
    }
  }
}
