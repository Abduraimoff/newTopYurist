
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';
import 'package:top_yurist/data/Models/application/publish_aplication.dart';
import '../../utils/config.dart';

class LawyerFavRepository{





  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<Response> getFavList() async{
    try{
      final Response response = await ApiRequest().doGetRequest(slug: "/api/user/favorite/lawyer_page", options: Options(headers: {
        "Authorization": await _storage.read(key: Config.accessToken)
      }),

      queryParameters: {
            "page": 1,
            "size": 100,
          }
      );
      return response;
    }catch(e){
      rethrow;
    }

  }


  Future<dynamic> applicationAddedToFavourite(String? id) async{
    try{
      final Response response = await ApiRequest().doPatchRequest(slug: "/api/application/favorite/add", queryParameters: {
        "id": id
      },
          options: Options(headers: {
            "Authorization": await _storage.read(key:  Config.accessToken)
          }));
      return PublishApplication.fromJson(response.data);
    } on DioError catch(e){

      rethrow;
    }

  }

}


