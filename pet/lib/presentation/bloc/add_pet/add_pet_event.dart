part of 'add_pet_bloc.dart';

abstract class AddPetEvent extends Equatable {
  const AddPetEvent();

  @override
  List<Object> get props => [];

}

class CreatePet extends AddPetEvent{
  final PetEntity petEntity;
  CreatePet({required this.petEntity});
  @override
  List<Object> get props => [petEntity];
}

class SetPhoto extends AddPetEvent{
}

class SetCertificate extends AddPetEvent{
}