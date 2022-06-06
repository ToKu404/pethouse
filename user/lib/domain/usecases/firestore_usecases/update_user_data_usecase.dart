import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class UpdateUserDataUsecase {
  final UserRepository firebaseRepository;

  UpdateUserDataUsecase({required this.firebaseRepository});

  Future<void> execute(UserEntity user) async {
    return firebaseRepository.updateUserDate(user);
  }
}
