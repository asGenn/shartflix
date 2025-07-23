import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UploadPhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageEvent extends UploadPhotoEvent {}

class UploadPhotoActionEvent extends UploadPhotoEvent {
  final File imageFile;
  UploadPhotoActionEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}
