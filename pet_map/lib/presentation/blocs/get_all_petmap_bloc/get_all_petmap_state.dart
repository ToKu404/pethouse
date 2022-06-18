part of 'get_all_petmap_bloc.dart';

abstract class GetAllPetMapState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllPetMapInitial extends GetAllPetMapState {}

class GetAllPetMapLoading extends GetAllPetMapState {}

class GetAllPetMapError extends GetAllPetMapState {
  final String message;

  GetAllPetMapError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetAllPetMapSuccess extends GetAllPetMapState {
  final List<PetMapEntity> petMap;

  GetAllPetMapSuccess({required this.petMap});

  @override
  List<Object> get props => [petMap];
}
