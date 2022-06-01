

import '../../entities/user_entity.dart';
import '../../repositories/user_firebase_repository.dart';

class SaveUserData {
  final FirebaseRepository firebaseRepository;

  SaveUserData({required this.firebaseRepository});

  Future<void> execute(UserEntity user) async {
    return firebaseRepository.saveUserData(user);
  }
}
