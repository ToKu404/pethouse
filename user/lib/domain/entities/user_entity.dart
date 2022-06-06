import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? uid;
  final String? imageUrl;

  const UserEntity(
      {required this.name, required this.email, this.uid, this.imageUrl});

  @override
  List<Object?> get props => [name, email, uid, imageUrl];
}
