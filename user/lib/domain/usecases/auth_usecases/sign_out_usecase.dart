import '../../repositories/user_repository.dart';

class SignOutUsecase {
  final UserRepository firebaseRepository;

  SignOutUsecase({required this.firebaseRepository});

  Future<void> execute() async {
    return await firebaseRepository.signOut();
  }
}
