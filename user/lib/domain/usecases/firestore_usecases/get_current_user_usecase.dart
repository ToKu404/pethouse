import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetCurrentUserUsecase {
  final UserRepository firebaseRepository;
  GetCurrentUserUsecase({required this.firebaseRepository});

  Stream<UserEntity> execute(String uid) {
    return firebaseRepository.getCurrentUser(uid);
  }
}
