part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetEmailChanged extends ResetPasswordEvent {
  final String email;
  const ResetEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SubmitResetPassword extends ResetPasswordEvent {}

class ResetPasswordInitial extends ResetPasswordEvent {}
