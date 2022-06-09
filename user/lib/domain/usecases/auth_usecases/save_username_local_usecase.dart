import 'package:user/domain/entities/user_entity.dart';
import 'package:user/domain/repositories/user_repository.dart';

class SaveDataLocalUsecase {
  final UserRepository userRepository;

  SaveDataLocalUsecase(this.userRepository);

  Future<void> execute(UserEntity user) {
    return userRepository.saveUserDataLocal(user);
  }
}
