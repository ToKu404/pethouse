import 'package:pet_map/domain/entities/pet_map_entity.dart';
import 'package:pet_map/domain/repositories/pet_map_repository.dart';

class GetAllPetMapUsecase {
  final PetMapRepository petMapRepository;

  GetAllPetMapUsecase(this.petMapRepository);

  Stream<List<PetMapEntity>> execute() {
    return petMapRepository.getAllPetMap();
  }
}
