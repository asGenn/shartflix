part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  final UserEntity? user;
  final String? errorMessage;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isFormValid;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  const SignupState({
    this.user,
    this.errorMessage,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isFormValid = false,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  @override
  List<Object?> get props => [
    user,
    errorMessage,
    name,
    email,
    password,
    confirmPassword,
    isPasswordVisible,
    isConfirmPasswordVisible,
    isFormValid,
    nameError,
    emailError,
    passwordError,
    confirmPasswordError,
  ];
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {
  const SignupLoading({
    super.name,
    super.email,
    super.password,
    super.confirmPassword,
    super.isPasswordVisible,
    super.isConfirmPasswordVisible,
    super.isFormValid,
    super.nameError,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
  });
}

final class SignupFormState extends SignupState {
  const SignupFormState({
    super.name,
    super.email,
    super.password,
    super.confirmPassword,
    super.isPasswordVisible,
    super.isConfirmPasswordVisible,
    super.isFormValid,
    super.nameError,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
  });
}

final class SignupSuccess extends SignupState {
  const SignupSuccess(UserEntity user) : super(user: user);
}

final class SignupFailure extends SignupState {
  const SignupFailure(
    String errorMessage, {
    super.name,
    super.email,
    super.password,
    super.confirmPassword,
    super.isPasswordVisible,
    super.isConfirmPasswordVisible,
    super.isFormValid,
    super.nameError,
    super.emailError,
    super.passwordError,
    super.confirmPasswordError,
  }) : super(errorMessage: errorMessage);
}
