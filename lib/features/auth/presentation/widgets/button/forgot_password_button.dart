import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ForgotPasswordButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(
          'auth.login.forgot_password'.tr(),
          style: textTheme.labelMedium?.copyWith(
            fontSize: 12,
            color: colorScheme.onSurface.withValues(alpha: 0.9),
            decoration: TextDecoration.underline,
            decorationColor: colorScheme.onSurface.withValues(alpha: 0.9),
            decorationThickness: 1,
          ),
        ),
      ),
    );
  }
}
