import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/repositories/pet_repository.dart';

class UpdatePetUsecase {
  final PetRepository petRepository;

  UpdatePetUsecase(this.petRepository);

  Future<void> execute(PetEntity petEntity) {
    return petRepository.updatePetData(petEntity);
  }
}
