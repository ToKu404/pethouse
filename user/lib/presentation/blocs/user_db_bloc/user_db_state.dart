part of 'user_db_bloc.dart';

abstract class UserDbState extends Equatable {
  const UserDbState();

  @override
  List<Object> get props => [];
}

class UserDbInitial extends UserDbState {}

class UserDbLoading extends UserDbState {}

class UserDbFailure extends UserDbState {
  final String message;

  const UserDbFailure({required this.message});
}

class SuccessGetData extends UserDbState {
  final UserEntity user;

  const SuccessGetData(this.user);
  @override
  List<Object> get props => [user];
}

class SuccessDeleteUser extends UserDbState {}
