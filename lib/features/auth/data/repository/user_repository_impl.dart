import 'dart:io';

import 'package:shartflix/core/error/error_handler.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/data/data_sources/local/secure_storage_service.dart';
import 'package:shartflix/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:shartflix/features/auth/data/models/login_request_model.dart';
import 'package:shartflix/features/auth/data/models/register_request_model.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;
  final AuthLocalStorage _secureStorage;

  UserRepositoryImpl(this._userApiService, this._secureStorage);

  @override
  Future<DataState<UserEntity>> login(LoginRequestModel loginRequest) async {
    try {
      final httpResponse = await _userApiService.login(loginRequest);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final userModel = httpResponse.data.data;
        if (userModel != null) {
          // Token'ı secure storage'a kaydet
          await _secureStorage.saveToken(userModel.token ?? '');

          // UserModel'i UserEntity'ye dönüştür
          final user = UserEntity(
            id: userModel.id,
            name: userModel.name,
            email: userModel.email,
            photoUrl: userModel.photoUrl,
            token: userModel.token,
          );

          return DataSuccess(user);
        } else {
          return const DataFailed('Login failed: No user data received');
        }
      } else {
        return DataFailed('Login failed: ${httpResponse.response.statusCode}');
      }
    } catch (e) {
      final appError = ErrorHandler.handleError(e);
      return DataFailed(appError.message);
    }
  }

  @override
  Future<DataState<UserEntity>> register(
    RegisterRequestModel registerRequest,
  ) async {
    try {
      final httpResponse = await _userApiService.register(registerRequest);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final userModel = httpResponse.data.data;
        if (userModel != null) {
          // Token'ı secure storage'a kaydet
          await _secureStorage.saveToken(userModel.token ?? '');

          // UserModel'i UserEntity'ye dönüştür
          final user = UserEntity(
            id: userModel.id,
            name: userModel.name,
            email: userModel.email,
            photoUrl: userModel.photoUrl,
            token: userModel.token,
          );

          return DataSuccess(user);
        } else {
          return const DataFailed('Registration failed: No user data received');
        }
      } else {
        return DataFailed(
          'Registration failed: ${httpResponse.response.statusCode}',
        );
      }
    } catch (e) {
      final appError = ErrorHandler.handleError(e);
      return DataFailed(appError.message);
    }
  }

  @override
  Future<DataState<UserEntity>> uploadPhoto(File file) async {
    try {
      final token = await _secureStorage.getToken();
      if (token == null) {
        return const DataFailed('No token found');
      }

      final httpResponse = await _userApiService.uploadPhoto(token, file);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final userModel = httpResponse.data.data;
        if (userModel != null) {
          // UserModel'i UserEntity'ye dönüştür
          final user = UserEntity(
            id: userModel.id,
            name: userModel.name,
            email: userModel.email,
            photoUrl: userModel.photoUrl,
            token: userModel.token,
          );

          return DataSuccess(user);
        } else {
          return const DataFailed('Photo upload failed: No user data received');
        }
      } else {
        return DataFailed(
          'Photo upload failed: ${httpResponse.response.statusCode}',
        );
      }
    } catch (e) {
      final appError = ErrorHandler.handleError(e);
      return DataFailed(appError.message);
    }
  }
}
