import '../entities/pet_entity.dart';

abstract class PetRepository {
  Future<void> addPet(PetEntity petEntity);
  Future<String> addPetPhoto(String? petPhotoUrl, String oldPhotoUrl);
  Future<String> addPetCertificate(
      String petCertificatePath, String oldCertificateUrl);
  Stream<List<PetEntity>> getPets(String userId);
  Stream<PetEntity> getPetDesc(String petId);
}
