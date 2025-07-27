import 'package:flutter/material.dart';

class PhotoUploadConfig {
  final String title;
  final String subtitle;
  final String buttonText;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSuccess;

  const PhotoUploadConfig({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.showBackButton = true,
    this.onBackPressed,
    this.onSuccess,
  });

  factory PhotoUploadConfig.forAuth() {
    return PhotoUploadConfig(
      title: 'profile.photo_upload.title',
      subtitle: 'profile.photo_upload.subtitle',
      buttonText: 'profile.photo_upload.button_text',
      showBackButton: false,
    );
  }

  factory PhotoUploadConfig.forProfile() {
    return PhotoUploadConfig(
      title: 'profile.photo_upload.title',
      subtitle: 'profile.photo_upload.subtitle',
      buttonText: 'profile.photo_upload.button_text',
      showBackButton: true,
    );
  }
}
