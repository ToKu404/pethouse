import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:petrivia/domain/repositories/petrivia_repository.dart';

class GetPetriviaUsecase {
  final PetriviaRepository petriviaRepository;

  GetPetriviaUsecase(this.petriviaRepository);

  Stream<List<PetriviaEntity>> execute() {
    return petriviaRepository.getListPetrivia();
  }
}
