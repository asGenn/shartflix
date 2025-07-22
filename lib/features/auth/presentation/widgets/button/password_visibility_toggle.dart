import 'package:flutter/material.dart';

class PasswordVisibilityToggle extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onToggle;

  const PasswordVisibilityToggle({
    super.key,
    required this.obscureText,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: const Color(0xff8C8C8C),
      ),
      onPressed: onToggle,
    );
  }
}
