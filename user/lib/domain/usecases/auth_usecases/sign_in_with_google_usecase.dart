import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user_repository.dart';

class SignInWithGoogle {
  final UserRepository firebaseRepository;

  SignInWithGoogle({required this.firebaseRepository});

  Future<UserCredential?> excute() {
    return firebaseRepository.signInWithGoogle();
  }
}
