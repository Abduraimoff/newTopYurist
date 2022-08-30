
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';
import '../../utils/config.dart';
import '../Models/regions/regions.dart';

class LawyerServiceRepository{

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<List<RegionsResponse>> getServiceList() async{
    try{
      final Response response = await ApiRequest().doGetRequest(slug: "/api/profile/lawyer/problem_type/list", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken)
      }));
      return regionsResponseFromJson(response.data);
    }catch(e){
      rethrow;
    }

  }
  Future<Response> removeService(List<String> ids) async{
    try{
      final Response response = await ApiRequest().doPutRequest(slug: "/api/profile/lawyer/problem_type/remove_all", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken)
      }), data: ids);
      return response;
    }catch(e){
      rethrow;
    }

  }
  Future<Response> addService(List<String> ids) async{
    try{
      final Response response = await ApiRequest().doPostRequest(slug: "/api/profile/lawyer/problem_type/add_all", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken)
      }), data: ids);
      return response;
    }catch(e){
      rethrow;
    }

  }
}