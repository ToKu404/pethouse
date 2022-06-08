part of 'edit_adopt_bloc.dart';

abstract class EditAdoptState extends Equatable {
  @override
  List<Object> get props => [];
}

class EditAdoptInitial extends EditAdoptState {}

class EditAdoptLoading extends EditAdoptState {}

class EditAdoptError extends EditAdoptState {
  final String message;

  EditAdoptError({required this.message});

  @override
  List<Object> get props => [message];
}

class EditAdoptSuccess extends EditAdoptState {}

class EditPetPhotoSuccess extends EditAdoptState {
  final String petPhotoPath;
  EditPetPhotoSuccess({required this.petPhotoPath});

  @override
  List<Object> get props => [petPhotoPath];
}

class EditPetCertificateSuccess extends EditAdoptState {
  final String petCertificatePath;
  final String petCertificateFileName;
  EditPetCertificateSuccess(
      {required this.petCertificatePath, required this.petCertificateFileName});

  @override
  List<Object> get props => [petCertificatePath, petCertificateFileName];
}


