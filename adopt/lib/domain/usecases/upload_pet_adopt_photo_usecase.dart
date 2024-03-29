import 'package:adopt/domain/repositories/adopt_repository.dart';

class UploadPetAdoptPhotoUsecase {
  final AdoptRepository adoptRepository;

  const UploadPetAdoptPhotoUsecase({required this.adoptRepository});

  Future<String> execute(String? petPhotoUrl, String oldPhotoUrl) async{
    return await adoptRepository.uploadPetAdoptPhoto(petPhotoUrl, oldPhotoUrl);
  }
}
