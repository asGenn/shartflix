import 'dart:io';
import 'package:shartflix/core/repository/base_repository.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:shartflix/features/auth/data/models/login_request_model.dart';
import 'package:shartflix/features/auth/data/models/user_model.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository with BaseRepository {
  final UserApiService _userApiService;

  UserRepositoryImpl(this._userApiService);

  @override
  Future<DataState<UserModel>> login(LoginRequestModel loginRequest) async {
    return handleApiCall<UserModel>(() async {
      final httpResponse = await _userApiService.login(loginRequest);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return httpResponse.data.data!;
      } else {
        throw Exception(
          'Login failed with status: ${httpResponse.response.statusCode}',
        );
      }
    });
  }
}
