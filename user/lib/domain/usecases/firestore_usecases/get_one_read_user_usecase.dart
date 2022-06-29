import 'package:user/domain/entities/user_entity.dart';
import 'package:user/domain/repositories/user_repository.dart';

class GetOneReadUserUsecase {
  final UserRepository userRepository;

  GetOneReadUserUsecase(this.userRepository);

  Future<UserEntity> execute() {
    return userRepository.getOneReadUser();
  }
}
