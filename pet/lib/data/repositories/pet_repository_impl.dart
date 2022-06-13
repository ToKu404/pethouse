import 'package:pet/data/data_sources/pet_data_source.dart';

import '../../domain/entities/pet_entity.dart';
import '../../domain/repositories/pet_repository.dart';

class PetRepositoryImpl implements PetRepository {
  final PetDataSource petFirebaseDataSource;

  PetRepositoryImpl({required this.petFirebaseDataSource});

  @override
  Future<void> addPet(PetEntity petEntity) async {
    return petFirebaseDataSource.addPet(petEntity);
  }

  @override
  Future<String> addPetPhoto(String? petPhotoUrl, String oldPhotoUrl) async {
    return petFirebaseDataSource.uploadPetAdoptPhoto(petPhotoUrl, oldPhotoUrl);
  }

  @override
  Future<String> addPetCertificate(
      String petCertificatePath, String oldCertificateUrl) {
    return petFirebaseDataSource.uploadPetCertificate(
        petCertificatePath, oldCertificateUrl);
  }

  @override
  Stream<List<PetEntity>> getPets(String userId) {
    return petFirebaseDataSource.getPets(userId);
  }

  @override
  Stream<PetEntity> getPetDesc(String petId) {
    return petFirebaseDataSource.getPetDesc(petId);
  }
}
