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
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: colorScheme.onSurface.withValues(alpha: 0.5),
      ),
      onPressed: onToggle,
    );
  }
}
