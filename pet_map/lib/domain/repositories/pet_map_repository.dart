import 'package:pet_map/domain/entities/pet_map_entity.dart';

abstract class PetMapRepository {
  Future<void> createPetMap(PetMapEntity petMapEntity);
  Future<void> removePetMap(String petMapId);
  Future<void> updatePetMap(PetMapEntity petMapEntity);
  Stream<List<PetMapEntity>> getAllPetMap();
  Stream<PetMapEntity> getPetMap(String petMapId);
  Future<bool> checkPetMap(String petMapId);
}
