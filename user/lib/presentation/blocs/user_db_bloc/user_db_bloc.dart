import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth_usecases/delete_user_usecase.dart';
import '../../../domain/usecases/firestore_usecases/get_current_user_usecase.dart';

part 'user_db_event.dart';
part 'user_db_state.dart';

class UserDbBloc extends Bloc<UserDbEvent, UserDbState> {
  final GetCurrentUserUsecase getUserFromDb;
  final DeleteUserUsecase deleteUserUsecase;

  UserDbBloc({required this.getUserFromDb, required this.deleteUserUsecase})
      : super(UserDbInitial()) {
    on<GetUserFromDb>(
      (event, emit) async {
        try {
          emit(UserDbLoading());
          getUserFromDb.execute(event.uid).listen((userData) {
            add(GetUserData(userData));
          });
        } on SocketException catch (_) {
          emit(const UserDbFailure(message: 'SocketException'));
        } catch (_) {
          emit(const UserDbFailure(message: "Error to Load Data"));
        }
      },
    );
    on<GetUserData>(
      (event, emit) {
        emit(SuccessGetData(event.userEntity));
      },
    );
    on<DeleteUserData>(
      (event, emit) async {
        emit(UserDbLoading());
        await deleteUserUsecase.execute(event.userEntity);
        emit(SuccessDeleteUser());
      },
    );
  }
}
