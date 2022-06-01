

import '../../repositories/user_firebase_repository.dart';

class SignOutUsecase {
  final FirebaseRepository firebaseRepository;

  SignOutUsecase({required this.firebaseRepository});

  Future<void> execute() async {
    return await firebaseRepository.signOut();
  }
}
