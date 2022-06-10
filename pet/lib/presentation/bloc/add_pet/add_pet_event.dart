part of 'add_pet_bloc.dart';

abstract class AddPetEvent extends Equatable {
  const AddPetEvent();

  @override
  List<Object> get props => [];
}

class AddPetInitEvent extends AddPetEvent {}

class SubmitAddPetEvent extends AddPetEvent {
  final PetEntity petEntity;

  const SubmitAddPetEvent({required this.petEntity});

  @override
  List<Object> get props => [petEntity];
}

class AddPetPhotoEvent extends AddPetEvent {}

class AddPetCertificateEvent extends AddPetEvent {}
