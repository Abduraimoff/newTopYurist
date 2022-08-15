
import 'package:dio/dio.dart';
import 'package:top_yurist/data/HttpRequest/http_requests.dart';

import '../Models/regions/regions.dart';

class RegionsRepository {
  final ApiRequest request = ApiRequest();
  Future<List<RegionsResponse>> getRegions()async{
    try{
      final Response response = await request.doGetRequest(slug: "/api/region/list");
      return regionsResponseFromJson(response.data);
    }catch(e){
      rethrow;
    }


  }
}