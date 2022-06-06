import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class GetAllPetListUsecase {
  final AdoptRepository adoptRepository;

  GetAllPetListUsecase({required this.adoptRepository});

  Stream<List<AdoptEntity>> execute() {
    return adoptRepository.getAllPetLists();
  }
}
