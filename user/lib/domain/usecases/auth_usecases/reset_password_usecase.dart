

import '../../repositories/user_firebase_repository.dart';

class ResetPasswordUsecase {
  final FirebaseRepository firebaseRepository;

  const ResetPasswordUsecase({required this.firebaseRepository});

  Future<void> execute(String email) async {
    return await firebaseRepository.resetPassword(email);
  }
}
