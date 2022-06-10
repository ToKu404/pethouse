part of 'get_pet_bloc.dart';

abstract class GetPetEvent extends Equatable {
  const GetPetEvent();
  @override
  List<Object> get props => [];
}

class GetListPet extends GetPetEvent {
  final List<PetEntity> listPet;

  const GetListPet({required this.listPet});

  @override
  List<Object> get props => [listPet];
}

class FetchListPet extends GetPetEvent {}
