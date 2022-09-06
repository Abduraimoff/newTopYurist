
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

import '../../utils/config.dart';

class ChatRepository{
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
 Future<Response> getChat({ String? state})async{
   try{
     final Response response = await ApiRequest().doGetRequest(slug: "/api/chat/page", options: Options(headers: {
       "Authorization": await _storage.read(key: Config.accessToken)
     }));
     return response;
   } catch(e){
     rethrow;
   }

 }
  Future<Response> getChatMessage({ String? state, String? chatId})async{
    try{
      final Response response = await ApiRequest().doGetRequest(slug: "/api/chat/message_page", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken)
      }), queryParameters: {
        "chat_id": chatId,
      });
      return response;
    } catch(e){
      rethrow;
    }

  }
}