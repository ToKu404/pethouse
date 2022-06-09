part of 'open_adopt_bloc.dart';

abstract class OpenAdoptState extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenAdoptInitial extends OpenAdoptState {}

class OpenAdoptLoading extends OpenAdoptState {}

class OpenAdoptError extends OpenAdoptState {
  final String message;

  OpenAdoptError({required this.message});

  @override
  List<Object> get props => [message];
}

class OpenAdoptSuccess extends OpenAdoptState {}

class UploadPetPhotoSuccess extends OpenAdoptState {
  final String petPhotoPath;
  UploadPetPhotoSuccess({required this.petPhotoPath});

  @override
  List<Object> get props => [petPhotoPath];
}

class UploadPetCertificateSuccess extends OpenAdoptState {
  final String petCertificatePath;
  final String petCertificateFileName;
  UploadPetCertificateSuccess({required this.petCertificatePath, required this.petCertificateFileName});

  @override
  List<Object> get props => [petCertificatePath, petCertificateFileName];
}

class RemoveAdoptSuccess extends OpenAdoptState {
  
}