import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

class AppSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    required SnackBarType type,
    IconData? customIcon,
    Duration? duration,
  }) {
    final config = _getSnackBarConfig(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(customIcon ?? config.icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: config.backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  static _SnackBarConfig _getSnackBarConfig(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarConfig(
          icon: Icons.check_circle,
          backgroundColor: Colors.green,
        );
      case SnackBarType.error:
        return _SnackBarConfig(icon: Icons.error, backgroundColor: Colors.red);
      case SnackBarType.warning:
        return _SnackBarConfig(
          icon: Icons.warning,
          backgroundColor: Colors.orange,
        );
      case SnackBarType.info:
        return _SnackBarConfig(icon: Icons.info, backgroundColor: Colors.blue);
    }
  }
}

class _SnackBarConfig {
  final IconData icon;
  final Color backgroundColor;

  _SnackBarConfig({required this.icon, required this.backgroundColor});
}
