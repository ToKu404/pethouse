import '../../repositories/user_repository.dart';

class GetUserIdUsecase {
  final UserRepository firebaseRepository;

  GetUserIdUsecase({required this.firebaseRepository});

  Future<String> execute() async {
    return firebaseRepository.retrieveUid();
  }
}
