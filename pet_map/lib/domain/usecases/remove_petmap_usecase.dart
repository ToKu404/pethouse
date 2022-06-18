import 'package:pet_map/domain/repositories/pet_map_repository.dart';

class RemovePetMapUsecase {
  final PetMapRepository repository;

  RemovePetMapUsecase(this.repository);

  Future<void> execute(String petMapId) {
    return repository.removePetMap(petMapId);
  }
}
