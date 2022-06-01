

import '../../entities/user_entity.dart';
import '../../repositories/user_firebase_repository.dart';

class DeleteUserUsecase {
  final FirebaseRepository firebaseRepository;

  DeleteUserUsecase({required this.firebaseRepository});

  Future<void> execute(UserEntity user) {
    return firebaseRepository.deleteUser(user);
  }
}
