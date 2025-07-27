import 'dart:io';

import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/data/data_sources/local/secure_storage_service.dart';
import 'package:shartflix/features/main/data/data_sources/remote/user_profile_api_service.dart';
import 'package:shartflix/features/main/domain/entities/user_entity.dart';
import 'package:shartflix/features/main/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final UserProfileApiService _apiService;
  final AuthLocalStorage _authLocalStorage;

  ProfileRepositoryImpl(this._apiService, this._authLocalStorage);

  @override
  Future<DataState<UserEntity>> updateProfilePhoto(File file) async {
    try {
      final token = await _authLocalStorage.getToken();
      if (token == null) {
        return const DataFailed('No token found');
      }

      final httpResponse = await _apiService.uploadPhoto(token, file);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final userModel = httpResponse.data.data;
        if (userModel != null) {
          
          final user = UserEntity(
            id: userModel.id,
            name: userModel.name,
            email: userModel.email,
            photoUrl: userModel.photoUrl,
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
      return DataFailed(e.toString());
    }
  }
}
