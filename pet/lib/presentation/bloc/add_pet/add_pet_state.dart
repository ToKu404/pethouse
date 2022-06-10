part of 'add_pet_bloc.dart';

abstract class AddPetState extends Equatable {
  const AddPetState();
  @override
  List<Object> get props => [];
}


class AddPetInitial extends AddPetState {}

class AddPetLoading extends AddPetState {}
class AddPetError extends AddPetState {
  final String message;

  AddPetError({required this.message});

  @override
  List<Object> get props => [message];
}

class AddPetSuccess extends AddPetState {}

class AddPetPhotoSuccess extends AddPetState {
  final String petPhotoPath;
  AddPetPhotoSuccess({required this.petPhotoPath});

  @override
  List<Object> get props => [petPhotoPath];
}

class AddPetCertificateSuccess extends AddPetState {
  final String petCertificatePath;
  final String petCertificateFileName;
  AddPetCertificateSuccess({required this.petCertificatePath, required this.petCertificateFileName});

  @override
  List<Object> get props => [petCertificatePath, petCertificateFileName];
}
