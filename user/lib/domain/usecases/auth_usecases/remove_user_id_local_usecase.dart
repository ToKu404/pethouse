import 'package:user/domain/repositories/user_repository.dart';

class RemoveUserIdLocalUsecase {
  final UserRepository userRepository;

  const RemoveUserIdLocalUsecase({required this.userRepository});

  Future<void> execute() async {
    return await userRepository.removeUserIdLocal();
  }
}
