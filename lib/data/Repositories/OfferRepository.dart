
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
  Future<Response> createOffer({String? id, String? description, String? price } ) async{
    try{
      final Response response = await ApiRequest().doPostRequest(slug: "/api/application/create_offer", queryParameters: {
        "id": id
      }, options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }), data: {
        "description": description,
        "offer_price": price
      });
      print(response.data);
      return response;
    }catch(e){
      rethrow;
    }
  }
  Future<Response> selectLawyer({String? id } ) async{
    try{
      final Response response = await ApiRequest().doPatchRequest(slug: "/api/offer/select_lawyer", queryParameters: {
        "offer_id": id
      }, options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }), );
      print(response.data);
      return response;
    }catch(e){
      rethrow;
    }
  }
  Future<Response> favourite({String? id } ) async{
    try{
      final Response response = await ApiRequest().doPatchRequest(slug: "/api/user/favorite/add", queryParameters: {
        "id": id
      }, options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }), );
      print(response.data);
      return response;
    }catch(e){
      rethrow;
    }
  }
  Future<Response> unfavourite({String? id } ) async{
    try{
      final Response response = await ApiRequest().doPatchRequest(slug: "/api/user/favorite/remove", queryParameters: {
        "id": id
      }, options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }), );
      print(response.data);
      return response;
    }catch(e){
      rethrow;
    }
  }
}