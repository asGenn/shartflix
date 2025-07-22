import 'package:flutter/material.dart';

// Auth sayfaları için başlık widget'ı
class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff8C8C8C),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
