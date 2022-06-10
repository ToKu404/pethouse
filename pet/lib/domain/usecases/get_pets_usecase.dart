import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/repositories/pet_repository.dart';

class GetPetsUsecase {
  final PetRepository petRepository;

  GetPetsUsecase(this.petRepository);

  Stream<List<PetEntity>> execute(String userId) {
    return petRepository.getPets(userId);
  }
}
