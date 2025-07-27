import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/shared/widgets/app_snackbar.dart';
import 'package:shartflix/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_button.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_text_button.dart';
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
                message: 'auth.signup.signup_success'.tr(),
                type: SnackBarType.success,
              );

              // Navigate to main app or login
            } else if (state is SignupFailure) {
              AppSnackbar.show(
                context: context,
                message: state.errorMessage ?? 'auth.signup.signup_failed'.tr(),
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
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: mediaQuery.height * 0.08),
                              // Title ve Subtitle
                              AuthTitle(
                                title: 'auth.signup.title'.tr(),
                                subtitle: 'auth.signup.subtitle'.tr(),
                              ),
                              SizedBox(height: mediaQuery.height * 0.04),

                              // Name Field
                              CustomTextField(
                                initialValue: state.name,
                                hintText: 'auth.signup.name'.tr(),
                                prefixSvgPath: 'assets/images/Add-User.svg',
                                keyboardType: TextInputType.name,
                                errorText: state.nameError,
                                onChanged: (value) {
                                  context.read<SignupBloc>().add(
                                    NameChanged(value),
                                  );
                                },
                              ),
                              SizedBox(height: mediaQuery.height * 0.015),

                              // Email Field
                              CustomTextField(
                                initialValue: state.email,
                                hintText: 'auth.signup.email'.tr(),
                                prefixSvgPath: 'assets/images/Message.svg',
                                keyboardType: TextInputType.emailAddress,
                                errorText: state.emailError,
                                onChanged: (value) {
                                  context.read<SignupBloc>().add(
                                    EmailChanged(value),
                                  );
                                },
                              ),
                              SizedBox(height: mediaQuery.height * 0.015),

                              // Password Field
                              CustomTextField(
                                initialValue: state.password,
                                hintText: 'auth.signup.password'.tr(),
                                prefixSvgPath: 'assets/images/Unlock.svg',
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
                              SizedBox(height: mediaQuery.height * 0.015),

                              // Confirm Password Field
                              CustomTextField(
                                initialValue: state.confirmPassword,
                                hintText: 'auth.signup.confirm_password'.tr(),
                                prefixSvgPath: 'assets/images/Unlock.svg',
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
                              SizedBox(height: mediaQuery.height * 0.015),

                              // Terms and Privacy Text
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'auth.signup.terms_text'.tr(),
                                    ),
                                    TextSpan(
                                      text: 'auth.signup.terms_link'.tr(),
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'auth.signup.terms_end'.tr(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: mediaQuery.height * 0.02),

                              // Signup Button
                              CustomButton(
                                text: 'auth.signup.signup_button'.tr(),
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
                              SizedBox(height: mediaQuery.height * 0.02),

                              // Social Signup Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialButton(
                                    iconSvgPath: 'assets/images/google.svg',
                                    onPressed: () {
                                      context.read<SignupBloc>().add(
                                        const SocialSignupRequested('google'),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8.44),
                                  SocialButton(
                                    iconSvgPath: 'assets/images/apple.svg',
                                    onPressed: () {
                                      context.read<SignupBloc>().add(
                                        const SocialSignupRequested('apple'),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8.44),
                                  SocialButton(
                                    iconSvgPath: 'assets/images/facebook.svg',
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
                    CustomTextButton(
                      firstText: '${'auth.signup.has_account'.tr()} ',
                      secondText: 'auth.signup.login_link'.tr(),
                      onSignUpPressed: () {
                        context.read<SignupBloc>().add(LoginRequested());
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
