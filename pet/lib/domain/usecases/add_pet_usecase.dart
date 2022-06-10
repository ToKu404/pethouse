import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/repositories/pet_repository.dart';

class AddPetUsecase {
  final PetRepository petRepository;

  AddPetUsecase(this.petRepository);

  Future<void> execute(PetEntity petEntity) {
    return petRepository.addPet(petEntity);
  }
}
