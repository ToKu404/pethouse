part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileValidate extends UserProfileState {
  final bool imageIsUpload;
  final String imageUrl;
  final bool isLoading;
  final String oldImageUrl;
  final String name;
  final String email;
  final bool isEmailValid;
  final bool isNameValid;
  final bool isFormValid;

  const UserProfileValidate(
      {required this.imageIsUpload,
      required this.imageUrl,
      required this.isLoading,
      required this.isEmailValid,
      required this.email,
      required this.oldImageUrl,
      required this.isNameValid,
      required this.isFormValid,
      required this.name});

  UserProfileValidate copyWith({
    String? imageUrl,
    bool? imageIsUpload,
    bool? isLoading,
    bool? isEmailValid,
    bool? isNameValid,
    String? name,
    String? oldImageUrl,
    String? email,
    bool? isFormValid,
  }) {
    return UserProfileValidate(
        imageIsUpload: imageIsUpload ?? this.imageIsUpload,
        imageUrl: imageUrl ?? this.imageUrl,
        isLoading: isLoading ?? this.isLoading,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isNameValid: isNameValid ?? this.isNameValid,
        name: name ?? this.name,
        email: email ?? this.email,
        oldImageUrl: oldImageUrl ?? this.oldImageUrl,
        isFormValid: isFormValid ?? this.isFormValid);
  }

  @override
  List<Object> get props => [
        imageIsUpload,
        imageUrl,
        isLoading,
        name,
        email,
        isNameValid,
        isEmailValid,
        isFormValid
        ,
        oldImageUrl,
      ];
}
