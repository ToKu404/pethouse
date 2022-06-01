import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user_firebase_repository.dart';

class SignInUsecase {
  final FirebaseRepository firebaseRepository;

  SignInUsecase({required this.firebaseRepository});

  Future<UserCredential?> execute(String email, String password) {
    return firebaseRepository.signIn(email, password);
  }
}
