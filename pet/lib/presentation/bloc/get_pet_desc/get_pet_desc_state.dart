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

  PetDescSuccess({required this.petEntity});

  @override
  List<Object> get props => [petEntity];
}
