

import '../../entities/user_entity.dart';
import '../../repositories/user_firebase_repository.dart';

class GetCurrentUserUsecase {
  final FirebaseRepository firebaseRepository;
  GetCurrentUserUsecase({required this.firebaseRepository});

  Stream<UserEntity> execute(String uid) {
    return firebaseRepository.getCurrentUser(uid);
  }
}
