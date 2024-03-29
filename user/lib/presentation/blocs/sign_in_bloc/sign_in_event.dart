part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInInit extends SignInEvent {}

class EmailChanged extends SignInEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignInEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SubmitSignIn extends SignInEvent {}

class SubmitSignInGoogle extends SignInEvent {}

class ShowHidePasswordPress extends SignInEvent {}
