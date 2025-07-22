import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ForgotPasswordButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: const Text(
          'Şifremi unuttum',
          style: TextStyle(
            color: Color(0xff8C8C8C),
            fontSize: 14,
            decoration: TextDecoration.underline,
            decorationColor: Color(0xff8C8C8C),
          ),
        ),
      ),
    );
  }
}
