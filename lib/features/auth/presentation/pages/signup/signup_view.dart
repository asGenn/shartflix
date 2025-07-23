import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/widgets/app_snackbar.dart';
import 'package:shartflix/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/password_visibility_toggle.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/social_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/form/custom_text_field.dart';
import 'package:shartflix/features/auth/presentation/widgets/text/auth_title.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              AppSnackbar.show(
                context: context,
                message: 'Kayıt işlemi başarılı!',
                type: SnackBarType.success,
              );

              // Navigate to main app or login
            } else if (state is SignupFailure) {
              AppSnackbar.show(
                context: context,
                message: state.errorMessage ?? 'Kayıt işlemi başarısız!',
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Title ve Subtitle
                              const AuthTitle(
                                title: 'Hoşgeldiniz',
                                subtitle:
                                    'Tempus varius a vitae interdum id\ntortor elementum tristique eleifend at.',
                              ),
                              const SizedBox(height: 48),

                              // Name Field
                              CustomTextField(
                                initialValue: state.name,
                                hintText: 'Ad Soyad',
                                prefixIcon: Icons.person_outline,
                                keyboardType: TextInputType.name,
                                errorText: state.nameError,
                                onChanged: (value) {
                                  context.read<SignupBloc>().add(
                                    NameChanged(value),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),

                              // Email Field
                              CustomTextField(
                                initialValue: state.email,
                                hintText: 'E-Posta',
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                errorText: state.emailError,
                                onChanged: (value) {
                                  context.read<SignupBloc>().add(
                                    EmailChanged(value),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),

                              // Password Field
                              CustomTextField(
                                initialValue: state.password,
                                hintText: 'Şifre',
                                prefixIcon: Icons.lock_outline,
                                obscureText: !state.isPasswordVisible,
                                errorText: state.passwordError,
                                onChanged: (value) {
                                  context.read<SignupBloc>().add(
                                    PasswordChanged(value),
                                  );
                                },
                                suffixIcon: PasswordVisibilityToggle(
                                  obscureText: !state.isPasswordVisible,
                                  onToggle: () {
                                    context.read<SignupBloc>().add(
                                      PasswordVisibilityToggled(),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Confirm Password Field
                              CustomTextField(
                                initialValue: state.confirmPassword,
                                hintText: 'Şifre Tekrar',
                                prefixIcon: Icons.lock_outline,
                                obscureText: !state.isConfirmPasswordVisible,
                                errorText: state.confirmPasswordError,
                                onChanged: (value) {
                                  context.read<SignupBloc>().add(
                                    ConfirmPasswordChanged(value),
                                  );
                                },
                                suffixIcon: PasswordVisibilityToggle(
                                  obscureText: !state.isConfirmPasswordVisible,
                                  onToggle: () {
                                    context.read<SignupBloc>().add(
                                      ConfirmPasswordVisibilityToggled(),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Terms and Privacy Text
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Color(0xff8C8C8C),
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Kullanıcı sözleşmesini ',
                                    ),
                                    TextSpan(
                                      text: 'okudum ve kabul ediyorum',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const TextSpan(
                                      text:
                                          '. Bu sözleşmeyi okuyarak devam ediniz lütfen.',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Signup Button
                              CustomButton(
                                text: 'Şimdi Kaydol',
                                isLoading: state is SignupLoading,
                                onPressed: () {
                                  context.read<SignupBloc>().add(
                                    SignupButtonPressed(
                                      name: state.name,
                                      email: state.email,
                                      password: state.password,
                                      confirmPassword: state.confirmPassword,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 32),

                              // Social Signup Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialButton(
                                    icon: Icons.g_mobiledata,
                                    onPressed: () {
                                      context.read<SignupBloc>().add(
                                        const SocialSignupRequested('google'),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8.44),
                                  SocialButton(
                                    icon: Icons.apple,
                                    onPressed: () {
                                      context.read<SignupBloc>().add(
                                        const SocialSignupRequested('apple'),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8.44),
                                  SocialButton(
                                    icon: Icons.facebook,
                                    onPressed: () {
                                      context.read<SignupBloc>().add(
                                        const SocialSignupRequested('facebook'),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Login Link
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Zaten bir hesabın var mı? ',
                            style: TextStyle(
                              color: Color(0xff8C8C8C),
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<SignupBloc>().add(LoginRequested());
                            },
                            child: const Text(
                              'Giriş Yap!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
