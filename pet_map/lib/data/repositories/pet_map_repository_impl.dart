import 'package:pet_map/data/data_sources/pet_map_data_source.dart';
import 'package:pet_map/domain/entities/pet_map_entity.dart';
import 'package:pet_map/domain/repositories/pet_map_repository.dart';

class PetMapRepositoryImpl implements PetMapRepository {
  final PetMapDataSource petMapDataSource;

  PetMapRepositoryImpl(this.petMapDataSource);
  @override
  Future<void> createPetMap(PetMapEntity petMapEntity) {
    return petMapDataSource.createPetMap(petMapEntity);
  }

  @override
  Stream<List<PetMapEntity>> getAllPetMap() {
    return petMapDataSource.getAllPetMap();
  }

  @override
  Future<void> removePetMap(String petMapId) {
    return petMapDataSource.removePetMap(petMapId);
  }

  @override
  Future<bool> checkPetMap(String petMapId) {
    return petMapDataSource.checkPetMap(petMapId);
  }

  @override
  Stream<PetMapEntity> getPetMap(String petMapId) {
    return petMapDataSource.getPetMap(petMapId);
  }

  @override
  Future<void> updatePetMap(PetMapEntity petMapEntity) {
    return petMapDataSource.updatePetMap(petMapEntity);
  }
}
