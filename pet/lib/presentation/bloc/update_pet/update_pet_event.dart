part of 'update_pet_bloc.dart';

abstract class UpdatePetEvent extends Equatable {
  const UpdatePetEvent();
  @override
  List<Object> get props => [];
}

class SubmitUpdatePetEvent extends UpdatePetEvent {
  final PetEntity petEntityNew;
  final PetEntity petEntityOld;

  SubmitUpdatePetEvent(
      {required this.petEntityNew, required this.petEntityOld});
}

class UpdatePetPhoto extends UpdatePetEvent{}

class UpdatePetCertificate extends UpdatePetEvent{}
