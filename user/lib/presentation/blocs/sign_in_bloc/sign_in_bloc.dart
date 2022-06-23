import 'package:core/services/text_generator_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/sign_in_usecase.dart';
import '../../../domain/usecases/auth_usecases/sign_in_with_google_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInValidate> {
  final SignInUsecase signInUsecase;
  final SignInWithGoogle signInWithGoogle;

  SignInBloc({
    required this.signInUsecase,
    required this.signInWithGoogle,
  }) : super(const SignInValidate(
            email: 'sample@gmail.com',
            password: "",
            isEmailValid: true,
            isPasswordValid: true,
            isFormValid: false,
            isLoading: false,
            isFormValidateFailed: false)) {
    on<SignInInit>(_signInInit);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SubmitSignIn>(_onSubmitSignIn);
    on<ShowHidePasswordPress>(_onShowHidePasswordPress);
    on<SubmitSignInGoogle>(_onSignInWithGoogle);
  }

  _signInInit(SignInInit event, Emitter<SignInValidate> emit) {
    emit(state.copyWith(
        email: 'sample@gmail.com',
        password: "",
        isEmailValid: true,
        isPasswordValid: true,
        isFormValid: false,
        isLoading: false,
        isFormValidateFailed: false));
  }


  bool _isEmailValid(String email) {
    return TextGeneratorHelper.emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return TextGeneratorHelper.passwordRegExp.hasMatch(password);
  }

  _onEmailChanged(EmailChanged event, Emitter<SignInValidate> emit) {
    emit(state.copyWith(
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  _onPasswordChanged(PasswordChanged event, Emitter<SignInValidate> emit) {
    emit(
      state.copyWith(
        isFormValidateFailed: false,
        errorMessage: "",
        password: event.password,
        isPasswordValid: _isPasswordValid(event.password),
      ),
    );
  }

  _onSubmitSignIn(SubmitSignIn event, Emitter<SignInValidate> emit) async {
    emit(state.copyWith(
        errorMessage: "",
        isFormValid:
            _isPasswordValid(state.password) && _isEmailValid(state.email),
        isLoading: true));
    if (state.isFormValid) {
      try {
        UserCredential? authUser =
            await signInUsecase.execute(state.email, state.password);

        if (authUser != null) {
          emit(
            state.copyWith(isLoading: false, errorMessage: ""),
          );
        } else {
          emit(state.copyWith(
              isLoading: false,
              errorMessage: "User not found",
              isFormValid: false));
        }
      } on FirebaseAuthException catch (e) {
        emit(
          state.copyWith(
              isLoading: false, errorMessage: e.message, isFormValid: false),
        );
      }
    } else {
      emit(
        state.copyWith(
            isLoading: false, isFormValid: false, isFormValidateFailed: true),
      );
    }
  }

  _onShowHidePasswordPress(
      ShowHidePasswordPress event, Emitter<SignInValidate> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  _onSignInWithGoogle(
      SubmitSignInGoogle event, Emitter<SignInValidate> emit) async {
    UserCredential? userCredential = await signInWithGoogle.excute();
    if (userCredential != null) {
      emit(state.copyWith(
          isFormValid: true, isLoading: false, errorMessage: ""));
    }
  }
}
