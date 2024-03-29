import 'package:adopt/domain/repositories/adopt_repository.dart';

class UploadPetCertificateUsecase {
  final AdoptRepository adoptRepository;

  const UploadPetCertificateUsecase({required this.adoptRepository});

  Future<String> execute(
      String petCertificatePath, String oldCertificateUrl) async {
    return await adoptRepository.uploadPetCertificate(
        petCertificatePath, oldCertificateUrl);
  }
}
