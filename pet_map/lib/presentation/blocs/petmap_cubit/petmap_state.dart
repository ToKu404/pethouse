part of 'petmap_cubit.dart';

abstract class PetmapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PetmapInitial extends PetmapState {}

class PetmapLoading extends PetmapState {}

class PetmapRemoveSuccess extends PetmapState {}

class PetmapCreateSuccess extends PetmapState {}

class PetmapRemoveFailure extends PetmapState {}

class PetmapCreateFailure extends PetmapState {}

class CheckPetMapExists extends PetmapState {}

class CheckPetMapEmpty extends PetmapState {}

class UpdatePetMapSuccess extends PetmapState {}

class UpdatePetMapError extends PetmapState {}


