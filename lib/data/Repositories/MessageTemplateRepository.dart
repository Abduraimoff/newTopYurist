
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/config.dart';
import '../HttpRequest/http_requests.dart';

class MessageTemplateRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<Response> getMessageTemplateList()async{
    try{
      final Response response = await ApiRequest().doGetRequest(slug: "/api/message_template/list", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }));
      return response;
    }catch(e){
      rethrow;
    }

  }
  Future<Response> createMessageTemplateList( String? description)async{
    try{
      final Response response = await ApiRequest().doPostRequest(slug: "/api/message_template/create", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }),
      data: {
        "description": description,
      }
      );
      return response;
    }catch(e){
      rethrow;
    }

  }
  Future<Response> templateUpdated( String? description, String? id)async{
    try{
      final Response response = await ApiRequest().doPutRequest(slug: "/api/message_template/update", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }),
          data: {
            "description": description,
          }, queryParameters: {
          "id": id
          }
      );
      return response;
    }catch(e){
      rethrow;
    }

  }
  Future<Response> templateDeleted( String? id)async{
    try{
      final Response response = await ApiRequest().doDeleteRequest(slug: "/api/message_template/delete", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken),
      }),
         queryParameters: {
            "id": id
          }
      );
      return response;
    }catch(e){
      rethrow;
    }

  }
}