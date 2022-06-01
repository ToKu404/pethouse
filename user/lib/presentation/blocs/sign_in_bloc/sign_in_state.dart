part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInValidate extends SignInState {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFormValid;
  final bool isFormValidateFailed;
  final bool isLoading;
  final bool isPasswordVisible;
  final String errorMessage;

  const SignInValidate(
      {required this.email,
      required this.password,
      required this.isEmailValid,
      required this.isPasswordValid,
      required this.isFormValid,
      required this.isFormValidateFailed,
      this.isPasswordVisible = false,
      required this.isLoading,
      this.errorMessage = ""});

  SignInValidate copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isFormValid,
    bool? isFormValidateFailed,
    bool? isLoading,
    bool? isPasswordVisible,
    String? errorMessage,
  }) {
    return SignInValidate(
        email: email ?? this.email,
        password: password ?? this.password,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isFormValid: isFormValid ?? this.isFormValid,
        isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
        errorMessage: errorMessage ?? this.errorMessage,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isLoading: isLoading ?? this.isFormValidateFailed);
  }

  @override
  List<Object> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        isFormValid,
        isLoading,
        errorMessage,
        isFormValidateFailed,
        isPasswordVisible,
      ];
}
