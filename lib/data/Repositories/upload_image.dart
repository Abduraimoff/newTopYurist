import 'dart:io';
import 'package:top_yurist/data/Repositories/profile_repository.dart';

Future<String?> uploadImage({required File? file}) async {
  if (file == null) {
    return null;
  }
  final profilerepository = ProfileRepository();
  final imageUrl = await profilerepository.uploadImage(image: file);
  return imageUrl.fullPath;
}
