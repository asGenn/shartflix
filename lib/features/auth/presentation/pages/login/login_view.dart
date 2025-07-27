import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/shared/widgets/app_snackbar.dart';
import 'package:shartflix/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_text_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/forgot_password_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/password_visibility_toggle.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/social_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/form/custom_text_field.dart';
import 'package:shartflix/features/auth/presentation/widgets/text/auth_title.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              
              final userName = state.user?.name.isNotEmpty == true 
                  ? state.user!.name 
                  : 'common.user'.tr();
              AppSnackbar.show(
                context: context,
                message: 'auth.login.welcome_message'.tr(namedArgs: {
                  'name': userName,
                }),
                type: SnackBarType.success,
              );
            } else if (state is LoginFailure) {
              AppSnackbar.show(
                context: context,
                message: state.errorMessage ?? 'auth.login.login_failed'.tr(),
                type: SnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            final mediaQuery = MediaQuery.of(context).size;
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  mediaQuery.width * 0.08,
                  mediaQuery.height * 0,
                  mediaQuery.width * 0.08,
                  mediaQuery.height * 0.01,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: mediaQuery.height * 0.25),
                            // Title ve Subtitle
                            AuthTitle(
                              title: 'auth.login.title'.tr(),
                              subtitle: 'auth.login.subtitle'.tr(),
                            ),
                            SizedBox(height: mediaQuery.height * 0.04),

                            // Email Field
                            CustomTextField(
                              initialValue: state.email,
                              hintText: 'auth.login.email'.tr(),
                              prefixSvgPath: 'assets/images/Message.svg',
                              keyboardType: TextInputType.emailAddress,
                              errorText: state.emailError,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(
                                  EmailChanged(value),
                                );
                              },
                            ),
                            SizedBox(height: mediaQuery.height * 0.015),

                            // Password Field
                            CustomTextField(
                              initialValue: state.password,
                              hintText: 'auth.login.password'.tr(),
                              prefixSvgPath: 'assets/images/Unlock.svg',
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
                            SizedBox(height: mediaQuery.height * 0.015),

                            // Forgot Password
                            ForgotPasswordButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                            ),
                            SizedBox(height: mediaQuery.height * 0.015),

                            // Login Button
                            CustomButton(
                              text: 'auth.login.login_button'.tr(),
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
                            SizedBox(height: mediaQuery.height * 0.04),

                            // Social Login Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialButton(
                                  iconSvgPath: 'assets/images/google.svg',
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      const SocialLoginRequested('google'),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8.44),
                                SocialButton(
                                  iconSvgPath: 'assets/images/apple.svg',
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      const SocialLoginRequested('apple'),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8.44),
                                SocialButton(
                                  iconSvgPath: 'assets/images/facebook.svg',
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

                    // Sign Up Link
                    CustomTextButton(
                      firstText: '${'auth.login.no_account'.tr()}  ',
                      secondText: 'auth.login.signup_link'.tr(),
                      onSignUpPressed: () {
                        context.read<LoginBloc>().add(SignupRequested());
                      },
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
