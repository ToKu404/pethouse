part of 'update_pet_bloc.dart';

abstract class UpdatePetState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdatePetInitial extends UpdatePetState {}

class UpdatePetLoading extends UpdatePetState {}

class UpdatePetError extends UpdatePetState {
  final String message;

  UpdatePetError({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdatePetSuccess extends UpdatePetState {}

class UpdatePetPhotoSuccess extends UpdatePetState {
  final String petPhotoPath;
  UpdatePetPhotoSuccess({required this.petPhotoPath});

  @override
  List<Object> get props => [petPhotoPath];
}

class UpdatePetCertificateSuccess extends UpdatePetState {
  final String petCertificatePath;
  final String petCertificateFileName;

  UpdatePetCertificateSuccess(
      {required this.petCertificatePath, required this.petCertificateFileName});

  @override
  List<Object> get props => [petCertificatePath, petCertificateFileName];
}
