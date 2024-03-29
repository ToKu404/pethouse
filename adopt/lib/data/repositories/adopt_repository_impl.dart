import 'package:adopt/data/data_sources/adopt_data_source.dart';
import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class AdoptRepositoryImpl implements AdoptRepository {
  final AdoptDataSource adoptDataSource;

  const AdoptRepositoryImpl({required this.adoptDataSource});
  @override
  Future<void> createNewAdopt(AdoptEntity adoptEntity) async {
    return adoptDataSource.createNewAdopt(adoptEntity);
  }

  @override
  Future<String> uploadPetAdoptPhoto(
      String? petPhotoUrl, String oldPhotoUrl) async {
    return adoptDataSource.uploadPetAdoptPhoto(petPhotoUrl, oldPhotoUrl);
  }

  @override
  Future<String> uploadPetCertificate(
      String petCertificatePath, String oldCertificateUrl) async {
    return adoptDataSource.uploadPetCertificate(
        petCertificatePath, oldCertificateUrl);
  }

  @override
  Stream<List<AdoptEntity>> getAllPetLists() {
    return adoptDataSource.getAllPetLists();
  }

  @override
  Stream<AdoptEntity> getPetDescription(String petId) {
    return adoptDataSource.getPetDescription(petId);
  }

  @override
  Future<String> getUserIdLocal() {
    return adoptDataSource.getUserIdLocal();
  }

  @override
  Future<void> updateAdopt(AdoptEntity adoptEntity) {
    return adoptDataSource.updateAdopt(adoptEntity);
  }

  @override
  Stream<List<AdoptEntity>> getOpenAdoptList(String userId) {
    return adoptDataSource.getOpenAdoptList(userId);
  }

  @override
  Future<void> requestAdopt(AdoptEntity adopt) {
    return adoptDataSource.requestAdopt(adopt);
  }

  @override
  Future<void> removeOpenAdopt(String adoptId) {
    return adoptDataSource.removeOpenAdopt(adoptId);
  }

  @override
  Stream<List<AdoptEntity>> searchPetAdopt(String query) {
    return adoptDataSource.searchPetAdopt(query);
  }

  @override
  Stream<List<AdoptEntity>> getRequestAdoptList(String userId) {
    return adoptDataSource.getRequestAdoptList(userId);
  }
}
