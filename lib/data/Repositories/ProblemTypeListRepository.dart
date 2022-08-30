
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';
import 'package:top_yurist/utils/config.dart';

class ProblemTypeListRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<Response> getProblems({String? regionId, String? problemT})async{
    final Response response = await ApiRequest().doGetRequest(slug: "/api/application/lawyer_page", queryParameters: {

      "problem_type_id": problemT,
      "state": "PUBLISHED"
    },
    options: Options(headers: {
      "Authorization": await _storage.read(key: Config.accessToken),
    })
    );
    return response;
  }
}