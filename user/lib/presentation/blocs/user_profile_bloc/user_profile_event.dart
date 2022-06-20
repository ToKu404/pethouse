part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class ImageUploaded extends UserProfileEvent {
  final String userId;
  final String oldImageUrl;
  const ImageUploaded(this.userId, this.oldImageUrl);

  @override
  List<Object> get props => [userId];
}

class UserProfileInit extends UserProfileEvent {
  final String imageUrl;
  final String name;
  final String email;

  const UserProfileInit(
      {required this.imageUrl, required this.name, required this.email});

  @override
  List<Object> get props => [imageUrl, name, email];
}

class UserEmailChanged extends UserProfileEvent {
  final String email;
  const UserEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class UserNameChanged extends UserProfileEvent {
  final String name;
  const UserNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class SubmitUpdate extends UserProfileEvent {
  final String userId;
  const SubmitUpdate(this.userId);

  @override
  List<Object> get props => [userId];
}
