import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class CreateNewAdoptUsecase {
  final AdoptRepository adoptRepository;

  CreateNewAdoptUsecase({required this.adoptRepository});

  Future<void> execute(AdoptEntity adoptEntity) {
    return adoptRepository.createNewAdopt(adoptEntity);
  }
}
