import '../../repositories/user_repository.dart';

class ResetPasswordUsecase {
  final UserRepository firebaseRepository;

  const ResetPasswordUsecase({required this.firebaseRepository});

  Future<void> execute(String email) async {
    return await firebaseRepository.resetPassword(email);
  }
}
