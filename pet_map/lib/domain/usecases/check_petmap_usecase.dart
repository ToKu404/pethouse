import 'package:pet_map/domain/repositories/pet_map_repository.dart';

class CheckPetMapUsecase {
  final PetMapRepository petMapRepository;

  CheckPetMapUsecase(this.petMapRepository);

  Future<bool> execute(String petMapId) {
    return petMapRepository.checkPetMap(petMapId);
  }
}
