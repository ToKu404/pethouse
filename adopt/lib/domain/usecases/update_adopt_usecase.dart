import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class UpdateAdoptUsecase {
  final AdoptRepository adoptRepository;

  const UpdateAdoptUsecase({required this.adoptRepository});

  Future<void> execute(AdoptEntity adoptEntity) {
    return adoptRepository.updateAdopt(adoptEntity);
  }
}
