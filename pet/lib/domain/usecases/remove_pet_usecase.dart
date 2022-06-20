import 'package:pet/domain/repositories/pet_repository.dart';

class RemovePetUsecase {
  final PetRepository petRepository;

  RemovePetUsecase(this.petRepository);

  Future<void> execute(String petId) {
    return petRepository.removePetData(petId);
  }
}
