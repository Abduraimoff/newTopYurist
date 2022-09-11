import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:top_yurist/data/data_provider/token_provider.dart';
import 'package:top_yurist/utils/config.dart';

class DioClient {
  final _tokenProvider = TokenProvider();

  final _dio = Dio()..options.baseUrl = Config.baseUrl;

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
      ),
    );
  }

  Future<void> _onError(DioError error, handler) async {
    print(error);
    return handler.next(error);
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path == "/api/refresh_token") {
      return handler.next(options);
    }
    var accessToken = await _tokenProvider.getAccessToken();
    if (kDebugMode) {
      print(accessToken);
    }
    if (accessToken == null || JwtDecoder.isExpired(accessToken)) {
      await _refreshToken();
      accessToken = await _tokenProvider.getAccessToken();
    }
    options.headers.addAll({"Authorization": accessToken});
    return handler.next(options);
  }

  Future<void> _refreshToken() async {
    const path = "/api/refresh_token";

    final refreshToken = await _tokenProvider.getRefreshToken();

    if (refreshToken == null || JwtDecoder.isExpired(refreshToken)) {
      print('error reauth');
      _tokenProvider.clearAllData();
      throw Exception('reauth');

    }

    try {
      final parametrs = {"token": refreshToken};
      final response = await _dio.post(path, queryParameters: parametrs);
      final accessToken = response.data["access_token"];
      final newRefreshToken = response.data["access_token"];
      await _tokenProvider.saveAccessToken(accessToken);
      await _tokenProvider.saveRefreshToken(newRefreshToken);
    } catch (e) {

      throw Exception('reauth');

    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Dio  getDio() {
    return _dio;
  }
}
