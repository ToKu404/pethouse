import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class SaveUserData {
  final UserRepository firebaseRepository;

  SaveUserData({required this.firebaseRepository});

  Future<void> execute(UserEntity user) async {
    return firebaseRepository.saveUserData(user);
  }
}
