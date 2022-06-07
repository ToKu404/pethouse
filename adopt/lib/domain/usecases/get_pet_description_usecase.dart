import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class GetPetDescriptionUsecase {
  final AdoptRepository adoptRepository;

  GetPetDescriptionUsecase({required this.adoptRepository});

  Stream<AdoptEntity> execute(String petId) {
    return adoptRepository.getPetDescription(petId);
  }
}
