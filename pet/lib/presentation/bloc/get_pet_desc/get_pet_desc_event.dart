part of 'get_pet_desc_bloc.dart';

abstract class GetPetDescEvent extends Equatable {
  const GetPetDescEvent();
  @override
  List<Object> get props => [];
}

class FetchPetDesc extends GetPetDescEvent {
  final String petId;

  const FetchPetDesc({required this.petId});

  @override
  List<Object> get props => [petId];
}

class GetPetDesc extends GetPetDescEvent {
  final PetEntity petEntity;

  const GetPetDesc({required this.petEntity});

  @override
  List<Object> get props => [petEntity];
}

class GetPetTodayTask extends GetPetDescEvent {
  final PetEntity petEntity;
  final List<TaskEntity> listTask;

  const GetPetTodayTask({required this.petEntity, required this.listTask});

  @override
  List<Object> get props => [petEntity, listTask];
}

class RemovePetEvent extends GetPetDescEvent {
  final String petId;

  const RemovePetEvent({required this.petId});

  @override
  List<Object> get props => [petId];
}
