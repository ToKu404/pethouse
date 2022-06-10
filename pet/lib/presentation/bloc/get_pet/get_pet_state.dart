part of 'get_pet_bloc.dart';

abstract class GetPetState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPetInitial extends GetPetState {}

class GetPetLoading extends GetPetState {}

class GetPetError extends GetPetState {
  final String message;
  GetPetError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetPetSuccess extends GetPetState {
  final List<PetEntity> listPet;

  GetPetSuccess({required this.listPet});

  
  @override
  List<Object> get props => [listPet];
}
