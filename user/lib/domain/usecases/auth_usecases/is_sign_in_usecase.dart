import '../../repositories/user_repository.dart';

class IsSignInUsecase {
  final UserRepository firebaseRepository;

  IsSignInUsecase({required this.firebaseRepository});

  Future<bool> execute() async {
    return firebaseRepository.isSignIn();
  }
}
