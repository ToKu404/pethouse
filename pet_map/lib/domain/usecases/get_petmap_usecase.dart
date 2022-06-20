import 'package:pet_map/domain/entities/pet_map_entity.dart';
import 'package:pet_map/domain/repositories/pet_map_repository.dart';

class GetPetMapUsecase {
  final PetMapRepository petMapRepository;
  GetPetMapUsecase(this.petMapRepository);

  Stream<PetMapEntity> execute(String petMapId) {
    return petMapRepository.getPetMap(petMapId);
  }
}
