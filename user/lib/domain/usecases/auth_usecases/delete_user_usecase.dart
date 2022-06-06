import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository firebaseRepository;

  DeleteUserUsecase({required this.firebaseRepository});

  Future<void> execute(UserEntity user) {
    return firebaseRepository.deleteUser(user);
  }
}
