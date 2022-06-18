part of 'get_petmap_bloc.dart';

abstract class GetPetMapEvent extends Equatable {
  const GetPetMapEvent();
  @override
  List<Object> get props => [];
}

class GetPetMap extends GetPetMapEvent {
  final PetMapEntity petMap;

  const GetPetMap({required this.petMap});

  @override
  List<Object> get props => [petMap];
}

class FetchPetMap extends GetPetMapEvent {
  final String id;
  FetchPetMap({required this.id});

    @override
  List<Object> get props => [id];
}
