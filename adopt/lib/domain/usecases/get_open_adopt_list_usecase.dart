import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class GetOpenAdoptListUsecase {
  final AdoptRepository adoptRepository;

  GetOpenAdoptListUsecase(this.adoptRepository);

  Stream<List<AdoptEntity>> execute(String userId) {
    return adoptRepository.getOpenAdoptList(userId);
  }
}
