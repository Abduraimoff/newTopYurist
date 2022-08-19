
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

import '../../utils/config.dart';
import '../Models/application/create_application_response.dart';

class ApplicationRepository{
  static const storage = FlutterSecureStorage();
  
  Future<CreateApplicationResponse> createApplication(Map<String, dynamic> data) async{
    try{
      final response = await ApiRequest().doPostRequest(slug: "/api/application/create", data: data, options: Options(headers: {
        "Authorization": await storage.read(key: Config.accessToken)
      }));

      return CreateApplicationResponse.fromJson(response.body);
    } on DioError catch(e){
      rethrow;
    }

  }
}