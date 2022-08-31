
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

import '../../utils/config.dart';

class ChatRepository{
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
 Future<Response> getChat({String? lawyerId, String? customerId, String? message})async{
   try{
     final Response response = await ApiRequest().doGetRequest(slug: "", options: Options(headers: {
       "Authorization": await _storage.read(key: Config.accessToken)
     }));
     return response;
   } catch(e){
     rethrow;
   }

 } 
}