part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends SignupEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class EmailChanged extends SignupEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignupEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class PasswordVisibilityToggled extends SignupEvent {}

class ConfirmPasswordVisibilityToggled extends SignupEvent {}

class SignupButtonPressed extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const SignupButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [name, email, password, confirmPassword];
}

class SocialSignupRequested extends SignupEvent {
  final String provider; // 'google', 'apple', 'facebook'
  const SocialSignupRequested(this.provider);

  @override
  List<Object> get props => [provider];
}

class LoginRequested extends SignupEvent {}
