

import 'dart:io';

import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';

class UploadPhotoUseCase {
  final UserRepository userRepository;

  UploadPhotoUseCase(this.userRepository);

  Future<DataState<UserEntity>> call(File file) async {
    return userRepository.uploadPhoto(file);
  }
}