import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenProviderKeys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
}

class TokenProvider {
  final _storage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String? value) async {
    if (value == null) return;
    await _storage.write(key: TokenProviderKeys.accessToken, value: "Bearer $value");
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: TokenProviderKeys.accessToken);
  }

  Future<void> saveRefreshToken(String? value) async {
    if (value == null) return;
    await _storage.write(key: TokenProviderKeys.refreshToken, value: value);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: TokenProviderKeys.refreshToken);
  }
}
