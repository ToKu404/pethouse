part of 'user_db_bloc.dart';

abstract class UserDbEvent extends Equatable {
  const UserDbEvent();

  @override
  List<Object> get props => [];
}

class GetUserFromDb extends UserDbEvent {
  final String uid;

  const GetUserFromDb(this.uid);

  @override
  List<Object> get props => [uid];
}

class GetUserData extends UserDbEvent {
  final UserEntity userEntity;

  const GetUserData(this.userEntity);

  @override
  List<Object> get props => [userEntity];
}

class GetUserFromLocal extends UserDbEvent {
  
}

class DeleteUserData extends UserDbEvent {
  final UserEntity userEntity;

  const DeleteUserData(this.userEntity);

  @override
  List<Object> get props => [userEntity];
}

class SaveUsernameLocal extends UserDbEvent {
  final String username;
  SaveUsernameLocal({required this.username});

    @override
  List<Object> get props => [username];
}
