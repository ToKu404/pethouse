import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/domain/usecases/auth_usecases/remove_user_id_local_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/save_user_data_local_usecase.dart';

import '../../../domain/usecases/auth_usecases/get_user_id_usecase.dart';
import '../../../domain/usecases/auth_usecases/is_sign_in_usecase.dart';
import '../../../domain/usecases/auth_usecases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUsecase isSignInUsecase;
  final GetUserIdUsecase getUserIdUsecase;
  final SignOutUsecase signOutUsecase;
  final SaveUserIdLocal saveUserIdLocal;
  final RemoveUserIdLocalUsecase removeUserIdLocalUsecase;
  AuthCubit({
    required this.isSignInUsecase,
    required this.getUserIdUsecase,
    required this.signOutUsecase,
    required this.saveUserIdLocal,
    required this.removeUserIdLocalUsecase,
  }) : super(AuthInitial());

  Future<void> authenticationStarted() async {
    try {
      final status = await isSignInUsecase.execute();
      if (status) {
        final uid = await getUserIdUsecase.execute();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    final uid = await getUserIdUsecase.execute();
    await saveUserIdLocal.execute(
      uid,
    );
    emit(Authenticated(uid: uid));
  }

  Future<void> loggedOut() async {
    await signOutUsecase.execute();
    await removeUserIdLocalUsecase.execute();
    emit(UnAuthenticated());
  }
}
