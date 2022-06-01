import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user_firebase_repository.dart';

class SignUpUsecase {
  final FirebaseRepository firebaseRepository;

  SignUpUsecase({required this.firebaseRepository});

  Future<UserCredential?> execute(String name, String email, String password) async {
    return firebaseRepository.signUp(name, email, password);
  }
}
