import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback? onSignUpPressed;

  const SignUpButton({super.key, this.onSignUpPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bir hesabın yok mu?  ',
            style: TextStyle(color: Color(0xff8C8C8C), fontSize: 14),
          ),
          GestureDetector(
            onTap: onSignUpPressed,
            child: const Text(
              'Kayıt Ol!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
