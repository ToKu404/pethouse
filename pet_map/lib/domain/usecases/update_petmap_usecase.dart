import 'package:pet_map/domain/entities/pet_map_entity.dart';
import 'package:pet_map/domain/repositories/pet_map_repository.dart';

class UpdatePetMapUsecase {
  final PetMapRepository petMapRepository;

  UpdatePetMapUsecase(this.petMapRepository);

  Future<void> execute(PetMapEntity petMapEntity) {
    return petMapRepository.updatePetMap(petMapEntity);
  }
}
