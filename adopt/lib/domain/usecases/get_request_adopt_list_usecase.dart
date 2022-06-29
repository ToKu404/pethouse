import 'package:adopt/adopt.dart';

class GetRequestAdoptListUsecase {
  final AdoptRepository adoptRepository;

  GetRequestAdoptListUsecase(this.adoptRepository);

  Stream<List<AdoptEntity>> execute(String adopterId) {
    return adoptRepository.getRequestAdoptList(adopterId);
  }
}
