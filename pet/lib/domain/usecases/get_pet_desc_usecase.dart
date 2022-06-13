import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/repositories/pet_repository.dart';

class GetPetDescUsecase {
  final PetRepository petRepository;

  GetPetDescUsecase({required this.petRepository});

  Stream<PetEntity> execute(String petId) {
    return petRepository.getPetDesc(petId);
  }
}
