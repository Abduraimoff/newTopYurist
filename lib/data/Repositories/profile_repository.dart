import 'dart:io';

import 'package:dio/dio.dart';
import 'package:top_yurist/data/HttpRequest/dio_client.dart';
import 'package:top_yurist/data/Models/auth/image_response.dart';
import 'package:top_yurist/data/Models/user/user.dart';

class ProfileRepository {
  final _request = DioClient().getDio();

  Future<void> getFAQ() async {
    const path = '/api/profile/faq';

    try {
      final responce = await _request.get(path);

      print(responce);
    } catch (e) {
      print(e);
    }
  }

  Future<User?> getUser() async {
    const path = '/api/profile/info/';

    final responce = await _request.get(path);
    final user = User.fromJson(responce.data);
    return user;
  }

  Future<void> editUser(User user) async {
    const path = '/api/registration';
    final parametrs = {
      'profile_photo': user.profilePhoto,
      'full_name': user.fullName,
      'region_id': user.regionId,
      'agreement': true,
      'problem_types': (user.userType == UserType.lawyer)
          ? user.problemTypes ?? []
          : user.problemTypes,
    };

    final responce = await _request.post(path, data: parametrs);
    print(responce);
  }

  Future<ImageResponse> uploadImage({File? image, String? category}) async {
    ImageResponse res = ImageResponse();
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image!.path),
      "category": "test"
    });
    try {
      final response = await _request.post(
        "/file/upload-unique",
        data: formData,
      );
      res.statusCode = response.statusCode;
      if (response.statusCode == 200) {
        return ImageResponse.fromJson(response.data);
      }
      if (response.statusCode == 400) {
        res.error = response.data;
        return res;
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
