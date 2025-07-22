import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? errorText;
  final bool enabled;

  const CustomTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff1a1a1a),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboardType,
            enabled: enabled,
            style: TextStyle(
              color: enabled ? Colors.white : const Color(0xff8C8C8C),
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xff8C8C8C),
                fontSize: 16,
              ),
              prefixIcon: Icon(prefixIcon, color: const Color(0xff8C8C8C)),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              // Error border'ı InputDecoration'da göstermiyoruz
              // çünkü Container'da border ile gösteriyoruz
              errorStyle: const TextStyle(height: 0),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
