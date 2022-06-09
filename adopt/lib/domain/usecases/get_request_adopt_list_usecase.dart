import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/repositories/adopt_repository.dart';

class GetRequestAdoptListUsecase {
  final AdoptRepository adoptRepository;

  GetRequestAdoptListUsecase(this.adoptRepository);

  Stream<List<AdoptEntity>> execute(String userId) {
    return adoptRepository.getRequestAdoptList(userId);
  }
}
