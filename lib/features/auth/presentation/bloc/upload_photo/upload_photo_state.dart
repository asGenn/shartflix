import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:shartflix/features/auth/domain/entities/user_entitiy.dart';

abstract class UploadPhotoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadPhotoInitial extends UploadPhotoState {}

class ImagePickedState extends UploadPhotoState {
  final File imageFile;
  ImagePickedState(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class UploadPhotoLoading extends UploadPhotoState {}

class UploadPhotoSuccess extends UploadPhotoState {
  final UserEntity user;
  UploadPhotoSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UploadPhotoError extends UploadPhotoState {
  final String message;
  UploadPhotoError(this.message);

  @override
  List<Object?> get props => [message];
}
