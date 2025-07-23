import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/data/models/login_request_model.dart';
import 'package:shartflix/features/auth/data/models/register_request_model.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';

abstract class UserRepository {

  Future<DataState<UserEntity>> login(
    LoginRequestModel loginRequest,
  );
  Future<DataState<UserEntity>> register(
    RegisterRequestModel registerRequest,
  );
}
