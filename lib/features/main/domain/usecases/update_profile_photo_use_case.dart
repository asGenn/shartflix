import 'dart:io';

import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/main/domain/entities/user_entity.dart';
import 'package:shartflix/features/main/domain/repository/profile_repository.dart';

class UpdateProfilePhotoUseCase {
  final ProfileRepository profileRepository;

  UpdateProfilePhotoUseCase(this.profileRepository);

  Future<DataState<UserEntity>> call(File file) async {
    return profileRepository.updateProfilePhoto(file);
  }
}
