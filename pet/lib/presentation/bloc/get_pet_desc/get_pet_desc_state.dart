part of 'get_pet_desc_bloc.dart';

abstract class GetPetDescState extends Equatable {
  @override
  List<Object> get props => [];
}

class PetDescInitial extends GetPetDescState {}

class PetDescLoading extends GetPetDescState {}

class PetDescError extends GetPetDescState {
  final String message;

  PetDescError({required this.message});

  @override
  List<Object> get props => [message];
}

class PetDescSuccess extends GetPetDescState {
  final PetEntity petEntity;
  final List<TaskEntity> listTask;

  PetDescSuccess({required this.petEntity, required this.listTask});

  @override
  List<Object> get props => [petEntity, listTask];
}

class RemovePetSuccess extends GetPetDescState {}
