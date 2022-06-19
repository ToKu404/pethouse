part of 'get_petmap_bloc.dart';

abstract class GetPetMapState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPetMapInitial extends GetPetMapState {}

class GetPetMapLoading extends GetPetMapState {}

class GetPetMapError extends GetPetMapState {
  final String message;
  GetPetMapError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetPetMapSuccess extends GetPetMapState {
  final PetMapEntity petMapEntity;

  GetPetMapSuccess({required this.petMapEntity});

    @override
  List<Object> get props => [petMapEntity];
}
