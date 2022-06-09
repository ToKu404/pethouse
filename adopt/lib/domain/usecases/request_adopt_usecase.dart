import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class RequestAdoptUsecase {
  final AdoptRepository adoptRepository;

  RequestAdoptUsecase(this.adoptRepository);

  Future<void> execute(AdoptEntity adopt) {
    return adoptRepository.requestAdopt(adopt);
  }
}
