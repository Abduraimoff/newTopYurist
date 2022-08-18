import 'package:top_yurist/data/HttpRequest/dio_client.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

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
}
