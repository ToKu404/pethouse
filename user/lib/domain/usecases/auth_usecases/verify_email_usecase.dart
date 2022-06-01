import '../../repositories/user_firebase_repository.dart';

class VerifyEmailUsecase {
  final FirebaseRepository firebaseRepository;
  const VerifyEmailUsecase({required this.firebaseRepository});

  Future<void> execute() {
    return firebaseRepository.verifyEmail();
  }
}
