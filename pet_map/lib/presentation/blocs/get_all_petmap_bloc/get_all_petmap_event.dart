part of 'get_all_petmap_bloc.dart';


abstract class GetAllPetMapEvent extends Equatable {
    const GetAllPetMapEvent();
  @override
  List<Object> get props => [];
}


class GetPetMaps extends GetAllPetMapEvent {
  final List<PetMapEntity> petMaps;

  const GetPetMaps({required this.petMaps});

  @override
  List<Object> get props => [petMaps];
}

class FetchAllPetMap extends GetAllPetMapEvent {}
