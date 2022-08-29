
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

import '../../utils/config.dart';
import '../Models/application/create_application_response.dart';
import '../Models/application/publish_aplication.dart';
import '../Models/user/user_home_request_list.dart';

class ApplicationRepository{
  static const storage = FlutterSecureStorage();
  
  Future<CreateApplicationResponse> createApplication(Map<String, dynamic> data) async{
    try{
      final Response response = await ApiRequest().doPostRequest(slug: "/api/application/create", data: data, options: Options(headers: {
        "Authorization": await storage.read(key:  Config.accessToken)
      }));

      return CreateApplicationResponse.fromJson(response.data);
    } on DioError catch(e){
      print(e.response?.data);
      rethrow;
    }
  }
  Future<CreateApplicationResponse> updateApplication(Map<String, dynamic> data, String? id) async{
    try{
      final Response response = await ApiRequest().doPutRequest(slug: "/api/application/update", data: data,
          queryParameters: {"id": id},
          options: Options(headers: {
        "Authorization": await storage.read(key:  Config.accessToken)
      }));

      return CreateApplicationResponse.fromJson(response.data);
    }catch(e){

      rethrow;
    }
  }
  Future<dynamic> publishApplication(String id) async{
    try{
      final Response response = await ApiRequest().doPatchRequest(slug: "/api/application/publish", queryParameters: {
        "id": id
      },
          options: Options(headers: {
        "Authorization": await storage.read(key:  Config.accessToken)
      }));
      return PublishApplication.fromJson(response.data);
    } on DioError catch(e){
      print(e.response?.data);
      rethrow;
    }

  }
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
  Future<dynamic> applicationDelete(String? id) async{
    try{
      final Response response = await ApiRequest().doDeleteRequest(slug: "/api/application/delete", queryParameters: {
        "id": id
      },
          options: Options(headers: {
            "Authorization": await storage.read(key:  Config.accessToken)
          }));
      return PublishApplication.fromJson(response.data);
    } on DioError catch(e){

      rethrow;
    }

  }
  Future<dynamic> applicationResumed(String? id) async{
    try{
      final Response response = await ApiRequest().doPatchRequest(slug: "/api/application/resume", queryParameters: {
        "id": id
      },
          options: Options(headers: {
            "Authorization": await storage.read(key:  Config.accessToken)
          }));
      return PublishApplication.fromJson(response.data);
    } on DioError catch(e){

      rethrow;
    }

  }
  Future<dynamic> applicationAddedToFavourite(String? id) async{
    try{
      final Response response = await ApiRequest().doPatchRequest(slug: "/api/application/favorite/add", queryParameters: {
        "id": id
      },
          options: Options(headers: {
            "Authorization": await storage.read(key:  Config.accessToken)
          }));
      return PublishApplication.fromJson(response.data);
    } on DioError catch(e){

      rethrow;
    }

  }
}