import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';
import 'package:top_yurist/utils/config.dart';

class UserFavoriteRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<Response> getUserFavoriteLowyerList() async{
    try{
      final Response response = await ApiRequest().doGetRequest(slug: "/api/user/favorite/", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken)
      }));
      return response;
    }catch(e){
      rethrow;
    }

  }
}