import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shartflix/core/repository/base_repository.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/data/data_sources/local/secure_storage_service_impl.dart';
import 'package:shartflix/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:shartflix/features/auth/data/models/login_request_model.dart';
import 'package:shartflix/features/auth/data/models/register_request_model.dart';
import 'package:shartflix/features/auth/data/models/user_model.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository with BaseRepository {
  final UserApiService _userApiService;
  final SecureStorageService _secureStorageService;

  UserRepositoryImpl(this._userApiService, this._secureStorageService);

  @override
  Future<DataState<UserModel>> login(LoginRequestModel loginRequest) async {
    return handleApiCall<UserModel>(() async {
      final httpResponse = await _userApiService.login(loginRequest);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        await _secureStorageService.saveToken(httpResponse.data.data!.token!);
        return httpResponse.data.data!;
      } else {
        throw Exception(
          'Login failed with status: ${httpResponse.response.statusCode}',
        );
      }
    });
  }

  @override
  Future<DataState<UserEntity>> register(RegisterRequestModel registerRequest) {
    return handleApiCall<UserModel>(() async {
      final httpResponse = await _userApiService.register(registerRequest);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        await _secureStorageService.saveToken(httpResponse.data.data!.token!);
        return httpResponse.data.data!;
      } else {
        throw Exception(
          'Register failed with status: ${httpResponse.response.statusCode}',
        );
      }
    });
  }

  @override
  Future<DataState<UserEntity>> uploadPhoto(File file) {
    return handleApiCall<UserModel>(() async {
      final token = await _secureStorageService.getToken();
      final httpResponse = await _userApiService.uploadPhoto(token!, file);
      print(httpResponse.data.data!);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data!;
      } else {
        throw Exception(
          'Upload photo failed with status: ${httpResponse.response.statusCode}',
        );
      }
    });
  }
}
