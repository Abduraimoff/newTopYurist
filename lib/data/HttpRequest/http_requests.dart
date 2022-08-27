
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/utils/config.dart';

class ApiRequest{
  final Dio dio = Dio();
  final _storage = const FlutterSecureStorage();

  api(){
    dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) async{
      option.headers["Authorization"] = "Bearer ${ await _storage.read(key: Config.refreshToken)}";
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
    final Dio newDio = Dio();
    final refreshToken = await _storage.read(key: Config.refreshToken);
    final accessToken = await _storage.read(key: Config.accessToken);
    try{

      final response = await newDio.post("${Config.baseUrl}/api/refresh_token/", queryParameters: {"token": "Bearer $refreshToken"}, options: Options(headers: {
        "Authorization": accessToken,
      }));
      if(response.statusCode == 200) {

        await _storage.write(key: Config.accessToken, value: response.data["access_token"]);
        await _storage.write(key: Config.refreshToken, value: response.data["refresh_token"]);
      }else{

        _storage.deleteAll();
      }


    } on DioError catch(e){
      print(e.response?.data);
    }

  }


  Future<dynamic> doPostRequest({required String slug,Map<String, dynamic>? queryParameters,
    Options? options,  data})async{
    try{
     final Response response =  await dio.post(Config.baseUrl+slug, queryParameters: queryParameters, options: options, data: data );
     print(response.statusCode);
     return response;
    } on DioError catch (e){

      rethrow;
    }

  }

  Future<Response> doGetRequest({required String slug,Map<String, dynamic>? queryParameters,
    Options? options,}) async{
    await api();
    try{
      final Response response = await dio.get(Config.baseUrl +slug, queryParameters: queryParameters, options: options);
      return response;
    }catch(e){
      rethrow;
    }
  }
  Future<dynamic> doPatchRequest({required String slug,Map<String, dynamic>? queryParameters,
    Options? options,  data})async{
    try{
      final Response response =  await dio.patch(Config.baseUrl+slug, queryParameters: queryParameters, options: options, data: data );
      print(response.statusCode);
      return response;
    } on DioError catch (e){

      rethrow;
    }

  }
}