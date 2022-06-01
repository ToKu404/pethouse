part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpValidate extends SignUpState {
  final String email;
  final String name;
  final String password;
  final String confirmPassword;
  final bool isEmailValid;
  final bool isNameValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isFormValid;
  final bool isFormValidateFailed;
  final bool isFormSuccessful;
  final bool isLoading;
  final bool isEmailVerified;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String errorMessage;

  const SignUpValidate(
      {required this.email,
      required this.password,
      required this.name,
      required this.confirmPassword,
      required this.isEmailValid,
      required this.isNameValid,
      required this.isPasswordValid,
      required this.isEmailVerified,
      required this.isConfirmPasswordValid,
      required this.isFormValid,
      required this.isFormValidateFailed,
      this.isPasswordVisible = false,
      this.isConfirmPasswordVisible = false,
      this.isFormSuccessful = false,
      required this.isLoading,
      this.errorMessage = ""});
  SignUpValidate copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? name,
    bool? isEmailValid,
    bool? isNameValid,
    bool? isPasswordValid,
    bool? isEmailVerified,
    bool? isConfirmPasswordValid,
    bool? isFormValid,
    bool? isFormValidateFailed,
    bool? isFormSuccessful,
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? errorMessage,
  }) {
    return SignUpValidate(
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isNameValid: isNameValid ?? this.isNameValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isConfirmPasswordValid:
            isConfirmPasswordValid ?? this.isConfirmPasswordValid,
        isFormValid: isFormValid ?? this.isFormValid,
        isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
        errorMessage: errorMessage ?? this.errorMessage,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isConfirmPasswordVisible:
            isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
        isFormSuccessful: isFormSuccessful ?? this.isFormSuccessful,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        isLoading: isLoading ?? this.isFormValidateFailed);
  }

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        name,
        isNameValid,
        isEmailValid,
        isPasswordValid,
        isFormValid,
        isLoading,
        errorMessage,
        isFormValidateFailed,
        isFormSuccessful,
        isConfirmPasswordVisible,
        isConfirmPasswordValid,
        isPasswordVisible,
        isEmailVerified
      ];
}
