import 'package:adopt/adopt.dart';

class SearchPetAdoptUsecase {
  final AdoptRepository adoptRepository;

  SearchPetAdoptUsecase(this.adoptRepository);

  Stream<List<AdoptEntity>> execute(String query) {
    return adoptRepository.searchPetAdopt(query);
  }
}
