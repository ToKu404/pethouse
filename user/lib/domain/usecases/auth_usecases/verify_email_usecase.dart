import '../../repositories/user_repository.dart';

class VerifyEmailUsecase {
  final UserRepository firebaseRepository;
  const VerifyEmailUsecase({required this.firebaseRepository});

  Future<void> execute() {
    return firebaseRepository.verifyEmail();
  }
}
