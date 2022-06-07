import 'package:adopt/domain/repositories/adopt_repository.dart';

class GetUserIdLocalUsecase {
  final AdoptRepository adoptRepository;

  GetUserIdLocalUsecase({required this.adoptRepository});

  Future<String> execute() {
    return adoptRepository.getUserIdLocal();
  }
}
