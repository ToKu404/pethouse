import 'package:pet/domain/repositories/pet_repository.dart';

class AddPetCertificateUsecase {
  final PetRepository petRepository;

  const AddPetCertificateUsecase({required this.petRepository});

  Future<String> execute(
      String petCertificatePath, String oldCertificateUrl) async {
    return await petRepository.addPetCertificate(
        petCertificatePath, oldCertificateUrl);
  }
}
