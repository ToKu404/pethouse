import 'package:adopt/domain/repositories/adopt_repository.dart';

class RemoveOpenAdoptUsecase {
  final AdoptRepository adoptRepository;

  RemoveOpenAdoptUsecase(this.adoptRepository);

  Future<void> execute(String adoptId) {
    return adoptRepository.removeOpenAdopt(adoptId);
  }
}
