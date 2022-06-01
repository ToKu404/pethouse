part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordValidate extends ResetPasswordState {
  final String email;
  final bool isEmailValid;
  final bool isLoading;
  final bool isSuccessResetPassword;
  final bool isSubmitResetPassword;
  final bool isFormValid;
  final String message;

  ResetPasswordValidate(
      {required this.email,
      required this.isEmailValid,
      required this.isLoading,
      required this.isSuccessResetPassword,
      required this.isSubmitResetPassword,
      required this.message,
      required this.isFormValid});

  ResetPasswordValidate copyWith({
    String? email,
    bool? isEmailValid,
    bool? isLoading,
    bool? isSuccessResetPassword,
    bool? isSubmitResetPassword,
    bool? isFormValid,
    String? message,
  }) {
    return ResetPasswordValidate(
        email: email ?? this.email,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isLoading: isLoading ?? this.isLoading,
        isSuccessResetPassword:
            isSuccessResetPassword ?? this.isSuccessResetPassword,
        message: message ?? this.message,
        isSubmitResetPassword:
            isSubmitResetPassword ?? this.isSubmitResetPassword,
        isFormValid: isFormValid ?? this.isFormValid);
  }

  @override
  List<Object> get props => [
        email,
        isEmailValid,
        isLoading,
        isSubmitResetPassword,
        isSuccessResetPassword,
        isFormValid,
        message
      ];
}
