import 'dart:io';

abstract class ProfilePhotoState {}

class ProfilePhotoInitial extends ProfilePhotoState {}

class ImagePickedState extends ProfilePhotoState {
  final File imageFile;

  ImagePickedState(this.imageFile);
}

class ProfilePhotoLoading extends ProfilePhotoState {}

class ProfilePhotoSuccess extends ProfilePhotoState {}

class ProfilePhotoError extends ProfilePhotoState {
  final String message;

  ProfilePhotoError(this.message);
}
