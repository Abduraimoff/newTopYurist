
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';
import 'package:top_yurist/data/Models/user/user_home_request_list.dart';
import 'package:top_yurist/utils/config.dart';

class UserRepository{
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<List<UserHomeRequestListResponse>> getUserRequestsList() async{
    try{
      final response = await ApiRequest().doGetRequest(slug: "/api/application/customer_list", options: Options(headers: {
        "Authorization": await storage.read(key: Config.accessToken),
      }));
      return userHomeRequestListResponseFromJson(response.data);
    } catch(e){
      rethrow;
    }

  }
}