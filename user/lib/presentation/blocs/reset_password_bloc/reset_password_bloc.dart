import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth_usecases/reset_password_usecase.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc
    extends Bloc<ResetPasswordEvent, ResetPasswordValidate> {
  final ResetPasswordUsecase resetPasswordUsecase;
  ResetPasswordBloc({required this.resetPasswordUsecase})
      : super(ResetPasswordValidate(
            email: '',
            isEmailValid: true,
            isFormValid: false,
            isLoading: false,
            message: '',
            isSubmitResetPassword: false,
            isSuccessResetPassword: false)) {
    on<SubmitResetPassword>(_onSubmitResetPassword);
    on<ResetEmailChanged>(_onEmailChanged);
    on<ResetPasswordInitial>(_onInitResetPassword);
  }

  bool _isEmailValid(String email) {
    return TextGeneratorHelper.emailRegExp.hasMatch(email);
  }

  _onEmailChanged(
      ResetEmailChanged event, Emitter<ResetPasswordValidate> emit) {
    emit(
      state.copyWith(
        isFormValid: false,
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
      ),
    );
  }

  _onInitResetPassword(
      ResetPasswordInitial event, Emitter<ResetPasswordValidate> emit) {
    emit(state.copyWith(
        email: '',
        isEmailValid: true,
        isFormValid: false,
        isLoading: false,
        isSubmitResetPassword: false,
        isSuccessResetPassword: false));
  }

  _onSubmitResetPassword(
      SubmitResetPassword event, Emitter<ResetPasswordValidate> emit) async {
    emit(state.copyWith(
        isFormValid: _isEmailValid(state.email), isLoading: true));
    if (state.isFormValid) {
      try {
        await resetPasswordUsecase.execute(state.email);
        emit(state.copyWith(isSubmitResetPassword: true, isLoading: false));
      } catch (_) {
        emit(state.copyWith(
            isLoading: false, message: 'Failed to send reset password email'));
      }
    } else {
      emit(state.copyWith(isLoading: false, message: 'Form Error'));
    }
  }
}
