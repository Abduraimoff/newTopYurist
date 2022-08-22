import 'package:top_yurist/data/HttpRequest/dio_client.dart';
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

    try {
      final responce = await _request.get(path);
      final user = User.fromJson(responce.data);
      return user;
    } catch (e) {
      return null;
    }
  }

  // Future<void> editUser(){

  // }
}
