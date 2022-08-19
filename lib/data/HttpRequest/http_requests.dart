
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/utils/config.dart';

class ApiRequest{
  final Dio dio = Dio();
  final _storage = const FlutterSecureStorage();
  String? accessToken;
  api(){
    dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) async{
      option.headers["Authorization"] = "Bearer $accessToken";
      return handler.next(option);
    }, onError: (DioError error, handler) async{
      if(error.response?.statusCode == 401){
        if(await _storage.containsKey(key: Config.refreshToken)){
       await refreshToken();
        }
      }
    }

    ));

  }
  Future<void> refreshToken()async{
    final refreshToken = await _storage.read(key: Config.refreshToken);
    final response = await dio.post("/api/refresh_token", queryParameters: {"token": refreshToken});
    if(response.statusCode == 200){
      accessToken = response.data["access_token"];
    }else{
      accessToken = null;
      _storage.deleteAll();
    }
  }


  Future<dynamic> doPostRequest({required String slug,Map<String, dynamic>? queryParameters,
    Options? options,  data})async{
    try{
     final Response response =  await dio.post(Config.baseUrl+slug, queryParameters: queryParameters, options: options, data: data );
     return response;
    } on DioError catch (e){

      rethrow;
    }

  }

  Future<Response> doGetRequest({required String slug,Map<String, dynamic>? queryParameters,
    Options? options,}) async{
    try{
      final Response response = await dio.get(Config.baseUrl +slug, queryParameters: queryParameters, options: options);
      return response;
    }catch(e){
      rethrow;
    }
  }
}