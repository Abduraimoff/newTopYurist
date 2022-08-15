
import 'package:top_yurist/data/HttpRequest/http_requests.dart';
import '../Models/regions/regions.dart';

class ProblemRepository{
  final ApiRequest request = ApiRequest();
  Future<List<RegionsResponse>> getProblemTypeList()async{
    final response = await request.doGetRequest(slug: "/api/problem_type/list");
    return regionsResponseFromJson(response.data);
  }
}