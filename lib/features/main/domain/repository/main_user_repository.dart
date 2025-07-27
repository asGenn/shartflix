import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/core/shared/entities/user_entity.dart';

abstract class MainUserRepository {
  Future<DataState<UserEntity?>> getCurrentUser();
}
