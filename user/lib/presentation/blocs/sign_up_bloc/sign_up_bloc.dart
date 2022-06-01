import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth_usecases/sign_up_usecase.dart';
import '../../../domain/usecases/auth_usecases/verify_email_usecase.dart';
import '../../../domain/usecases/firestore_usecases/save_user_data_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpValidate> {
  final SignUpUsecase signUpUsecase;
  final SaveUserData saveUserData;
  final VerifyEmailUsecase verifyEmailUsecase;
  SignUpBloc(
      {required this.signUpUsecase,
      required this.saveUserData,
      required this.verifyEmailUsecase})
      : super(
          const SignUpValidate(
            email: 'sample@gmail.com',
            password: '',
            name: 'sample',
            confirmPassword: '',
            isEmailValid: true,
            isNameValid: true,
            isPasswordValid: true,
            isConfirmPasswordValid: true,
            isFormValid: false,
            isFormValidateFailed: false,
            isLoading: false,
            isEmailVerified: false,
          ),
        ) {
    on<SignUpInit>(_signUpInit);
    on<EmailChanged>(_onEmailChanged);
    on<NameChanged>(_onNameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<FormSucceeded>(_onFormSucceeded);
    on<SubmitSignUp>(_onSubmitSignUp);
    on<ShowHidePasswordPress>(_onShowHidePasswordPress);
    on<ShowHideConfirmPasswordPress>(_onShowHideConfirmPasswordPress);
  }

  _signUpInit(SignUpInit event, Emitter<SignUpValidate> emit) {
    emit(state.copyWith(
      email: 'sample@gmail.com',
      password: '',
      name: 'sample',
      confirmPassword: '',
      isEmailValid: true,
      isNameValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isFormValid: false,
      isFormValidateFailed: false,
      isLoading: false,
    ));
  }

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  bool _isConfirmPasswordValid(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  bool _isNameValid(String? displayName) {
    return displayName!.isNotEmpty;
  }

  _onEmailChanged(EmailChanged event, Emitter<SignUpValidate> emit) {
    emit(
      state.copyWith(
        isFormSuccessful: false,
        isFormValid: false,
        isFormValidateFailed: false,
        errorMessage: "",
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
      ),
    );
  }

  _onPasswordChanged(PasswordChanged event, Emitter<SignUpValidate> emit) {
    emit(
      state.copyWith(
        isFormSuccessful: false,
        isFormValidateFailed: false,
        errorMessage: "",
        password: event.password,
        isPasswordValid: _isPasswordValid(event.password),
        isConfirmPasswordValid:
            _isConfirmPasswordValid(event.password, state.confirmPassword),
      ),
    );
  }

  _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<SignUpValidate> emit) {
    emit(
      state.copyWith(
        isFormSuccessful: false,
        isFormValidateFailed: false,
        errorMessage: "",
        confirmPassword: event.confirmPassword,
        isConfirmPasswordValid:
            _isConfirmPasswordValid(state.password, event.confirmPassword),
      ),
    );
  }

  _onNameChanged(NameChanged event, Emitter<SignUpValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      name: event.name,
      isNameValid: _isNameValid(event.name),
    ));
  }

  _onFormSucceeded(FormSucceeded event, Emitter<SignUpValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }

  _onSubmitSignUp(SubmitSignUp event, Emitter<SignUpValidate> emit) async {
    emit(state.copyWith(
        errorMessage: "",
        isFormValid: _isPasswordValid(state.password) &&
            _isEmailValid(state.email) &&
            _isNameValid(state.name) &&
            _isConfirmPasswordValid(state.password, state.confirmPassword),
        isLoading: true));
    if (state.isFormValid) {
      try {
        UserCredential? user = await signUpUsecase.execute(
            state.name, state.email, state.password);
        // await verifyEmailUsecase.execute();
        final userEntity = UserEntity(name: state.name, email: state.email);
        await saveUserData.execute(userEntity);
        emit(state.copyWith(isLoading: false, errorMessage: ""));
        // if (user?.user?.emailVerified ?? false) {
        //   emit(state.copyWith(isLoading: false, errorMessage: ""));
        // } else {
        //   emit(state.copyWith(
        //       isLoading: false,
        //       errorMessage: 'Verification email has send to ${state.email}'));
        // }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  _onShowHidePasswordPress(
      ShowHidePasswordPress event, Emitter<SignUpValidate> emit) {
    emit(
      state.copyWith(isPasswordVisible: !state.isPasswordVisible),
    );
  }

  _onShowHideConfirmPasswordPress(
      ShowHideConfirmPasswordPress event, Emitter<SignUpValidate> emit) {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }
}
