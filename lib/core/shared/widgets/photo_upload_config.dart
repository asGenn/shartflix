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
    return const PhotoUploadConfig(
      title: 'Fotoğraflarınızı Yükleyin',
      subtitle: 'Resources out incentivize\nrelaxation floor loss cc.',
      buttonText: 'Devam Et',
      showBackButton: false,
    );
  }

  factory PhotoUploadConfig.forProfile() {
    return const PhotoUploadConfig(
      title: 'Profil Fotoğrafını Güncelle',
      subtitle: 'Profilinizi daha çekici hale getirin',
      buttonText: 'Güncelle',
      showBackButton: true,
    );
  }
}
