import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/forgot_password_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/password_visibility_toggle.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/signup_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/social_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/form/custom_text_field.dart';
import 'package:shartflix/features/auth/presentation/widgets/text/auth_title.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('Hoş geldin ${state.user?.name ?? 'Kullanıcı'}!'),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(state.errorMessage ?? 'Giriş başarısız!'),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
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
                              title: 'Merhabalar',
                              subtitle:
                                  'Tempus varius a vitae interdum id\ntortor elementum tristique eleifend at.',
                            ),
                            const SizedBox(height: 48),

                            // Email Field
                            // Email Field
                            CustomTextField(
                              initialValue: state.email,
                              hintText: 'E-Posta',
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              errorText: state.emailError,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(
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
                                context.read<LoginBloc>().add(
                                  PasswordChanged(value),
                                );
                              },
                              suffixIcon: PasswordVisibilityToggle(
                                obscureText: !state.isPasswordVisible,
                                onToggle: () {
                                  context.read<LoginBloc>().add(
                                    PasswordVisibilityToggled(),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Forgot Password
                            ForgotPasswordButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                            ),
                            const SizedBox(height: 32),

                            // Login Button
                            CustomButton(
                              text: 'Giriş Yap',
                              isLoading: state is LoginLoading,
                              onPressed: () => {
                                context.read<LoginBloc>().add(
                                  LoginButtonPressed(
                                    email: state.email,
                                    password: state.password,
                                  ),
                                ),
                              },
                            ),
                            const SizedBox(height: 32),

                            // Social Login Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialButton(
                                  icon: Icons.g_mobiledata,
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      const SocialLoginRequested('google'),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8.44),
                                SocialButton(
                                  icon: Icons.apple,
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      const SocialLoginRequested('apple'),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8.44),
                                SocialButton(
                                  icon: Icons.facebook,
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      const SocialLoginRequested('facebook'),
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

                  // Sign Up Link
                  SignUpButton(
                    onSignUpPressed: () {
                      // Navigate to sign up
                      // Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
