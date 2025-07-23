import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shartflix/core/util/constants/local/local_constants.dart';
import 'package:shartflix/features/auth/data/data_sources/local/secure_storage_service.dart';

class SecureStorageService implements AuthLocalStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService(this._secureStorage);

  

  @override
  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: tokenKey, value: token);
    } catch (e) {
      throw Exception('Token kaydedilemedi: $e');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: tokenKey);
    } catch (e) {
      throw Exception('Token okunamadı: $e');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _secureStorage.delete(key: tokenKey);
    } catch (e) {
      throw Exception('Token silinemedi: $e');
    }
  }
}
