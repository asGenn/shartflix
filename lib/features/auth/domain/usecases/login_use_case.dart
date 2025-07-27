import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/core/shared/usecase/usecase.dart';
import 'package:shartflix/features/auth/data/models/login_request_model.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';

class LoginUseCase implements UseCase<DataState<UserEntity>,LoginRequestModel> {
  final UserRepository _userRepository;
  LoginUseCase(this._userRepository);
  @override
  Future<DataState<UserEntity>> call(LoginRequestModel params) {
    return _userRepository.login(params);
  }
}