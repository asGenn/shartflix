import 'dart:io';

import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/core/shared/entities/user_entity.dart';
import 'package:shartflix/features/auth/data/data_sources/local/secure_storage_service.dart';
import 'package:shartflix/features/main/data/data_sources/remote/user_profile_api_service.dart';
import 'package:shartflix/features/main/domain/repository/main_user_repository.dart';

class MainUserRepositoryImpl implements MainUserRepository {
  final UserProfileApiService _userApiService;
  final AuthLocalStorage _secureStorage;

  MainUserRepositoryImpl(this._userApiService, this._secureStorage);

  @override
  Future<DataState<UserEntity?>> getCurrentUser() async {
    try {
      final token = await _secureStorage.getToken();

      if (token == null) {
        return const DataSuccess(null);
      }

      final httpResponse = await _userApiService.getUserProfile(token);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final userModel = httpResponse.data.data;

        if (userModel != null) {
          
          final user = UserEntity(
            id: userModel.id,
            name: userModel.name,
            email: userModel.email,
            photoUrl: userModel.photoUrl,
            token: userModel.token,
          );

          return DataSuccess(user);
        } else {
          return const DataFailed('User data not found');
        }
      } else {
        return DataFailed(
          'Failed to get user profile: ${httpResponse.response.statusCode}',
        );
      }
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
