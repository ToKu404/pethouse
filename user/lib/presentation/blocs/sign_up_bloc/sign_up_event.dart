part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class NameChanged extends SignUpEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class PasswordChanged extends SignUpEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SignUpInit extends SignUpEvent {}

class SubmitSignUp extends SignUpEvent {}

class FormSucceeded extends SignUpEvent {}

class ShowHidePasswordPress extends SignUpEvent {}

class ShowHideConfirmPasswordPress extends SignUpEvent {}

