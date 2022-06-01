import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user_firebase_repository.dart';

class SignInWithGoogle {
  final FirebaseRepository firebaseRepository;

  SignInWithGoogle({required this.firebaseRepository});

  Future<UserCredential?> excute() {
    return firebaseRepository.signInWithGoogle();
  }
}
