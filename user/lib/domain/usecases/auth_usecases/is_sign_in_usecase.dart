

import '../../repositories/user_firebase_repository.dart';

class IsSignInUsecase {
  final FirebaseRepository firebaseRepository;

  IsSignInUsecase({required this.firebaseRepository});

  Future<bool> execute() async {
    return firebaseRepository.isSignIn();
  }
}
