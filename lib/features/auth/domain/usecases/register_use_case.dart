

import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/core/usecase/usecase.dart';
import 'package:shartflix/features/auth/data/models/register_request_model.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';

class RegisterUseCase extends UseCase<DataState<UserEntity>, RegisterRequestModel> {
  final UserRepository _userRepository;
  RegisterUseCase(this._userRepository);
  
  @override
  Future<DataState<UserEntity>> call(RegisterRequestModel params) {
    return _userRepository.register(params);
  }
  
  
}