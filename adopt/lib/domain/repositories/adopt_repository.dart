import 'package:adopt/domain/entities/adopt_enitity.dart';

abstract class AdoptRepository {
  Future<void> createNewAdopt(AdoptEntity adoptEntity);
  Future<String> uploadPetAdoptPhoto(String? petPhotoUrl, String oldPhotoUrl);
  Future<String> uploadPetCertificate(
      String petCertificatePath, String oldCertificateUrl);
  Future<String> getUserIdLocal();
  Stream<List<AdoptEntity>> getAllPetLists();
  Stream<AdoptEntity> getPetDescription(String petId);
  Future<void> updateAdopt(AdoptEntity adoptEntity);
  Stream<List<AdoptEntity>> getOpenAdoptList(String userId);
  Stream<List<AdoptEntity>> getRequestAdoptList(String userId);
  Stream<List<AdoptEntity>> searchPetAdopt(String query);
  Future<void> requestAdopt(AdoptEntity adopt);
  Future<void> removeOpenAdopt(String adoptId);
}
