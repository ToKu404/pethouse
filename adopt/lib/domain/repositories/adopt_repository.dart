import 'package:adopt/domain/entities/adopt_enitity.dart';

abstract class AdoptRepository {
  Future<void> createNewAdopt(AdoptEntity adoptEntity);
  Future<String> uploadPetAdoptPhoto(String? petPhotoUrl);
  Future<String> uploadPetCertificate(String petCertificatePath);
  Future<String> getUserIdLocal();
  Stream<List<AdoptEntity>> getAllPetLists();
  Stream<AdoptEntity> getPetDescription(String petId);
}
