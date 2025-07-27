import 'dart:io';

import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/main/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<DataState<UserEntity>> updateProfilePhoto(File photo);
}
