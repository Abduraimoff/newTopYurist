import 'dart:io';

import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

Future<File?> pickImage() async {
  try {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    if (image == null) {
      return null;
    }
    final temporaryImage = File(image.path);
    return temporaryImage;
  } catch (e) {
    print("filed to pick image: $e");
  }
}
