import 'dart:io';

abstract class ProfilePhotoEvent {}

class PickImageEvent extends ProfilePhotoEvent {}

class UpdateProfilePhotoEvent extends ProfilePhotoEvent {
  final File imageFile;

  UpdateProfilePhotoEvent(this.imageFile);
}

class UploadProfileButtonPressedEvent extends ProfilePhotoEvent {}