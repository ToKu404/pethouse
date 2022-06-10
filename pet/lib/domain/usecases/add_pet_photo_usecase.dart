import 'package:pet/domain/repositories/pet_repository.dart';

class AddPetPhotoUsecase {
  final PetRepository petRepository;

  const AddPetPhotoUsecase({required this.petRepository});

  Future<String> execute(String? petPhotoUrl, String oldPhotoUrl) async{
    return await petRepository.addPetPhoto(petPhotoUrl, oldPhotoUrl);
  }
}
