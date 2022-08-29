
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

import '../../utils/config.dart';

class OfferRepository{
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<Response> getOfferList(Map<String, dynamic> query, ) async{
    try{
      final Response response = await ApiRequest().doGetRequest(slug: "/api/application/offer_page", queryParameters: query, options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }) );
      return response;
    }catch(e){
      rethrow;
    }
  }
}