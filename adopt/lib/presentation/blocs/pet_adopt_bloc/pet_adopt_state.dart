part of 'pet_adopt_bloc.dart';

abstract class PetAdoptState extends Equatable {
  @override
  List<Object> get props => [];
}

class PetAdoptInitial extends PetAdoptState {}

class PetAdoptLoading extends PetAdoptState {}

class PetAdoptError extends PetAdoptState {
  final String message;

  PetAdoptError({required this.message});

  @override
  List<Object> get props => [message];
}

class OpenAdoptSuccess extends PetAdoptState {}

class UploadPetPhotoSuccess extends PetAdoptState {
  final String petPhotoPath;
  UploadPetPhotoSuccess({required this.petPhotoPath});

  @override
  List<Object> get props => [petPhotoPath];
}

class UploadPetCertificateSuccess extends PetAdoptState {
  final String petCertificatePath;
  final String petCertificateFileName;
  UploadPetCertificateSuccess(
      {required this.petCertificatePath, required this.petCertificateFileName});

  @override
  List<Object> get props => [petCertificatePath, petCertificateFileName];
}

class ListPetAdoptLoaded extends PetAdoptState {
  final List<AdoptEntity> listAdoptEntity;

  ListPetAdoptLoaded({required this.listAdoptEntity});
}
