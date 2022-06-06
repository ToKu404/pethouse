import 'package:user/domain/repositories/user_repository.dart';

class SaveUserIdLocal {
  final UserRepository repository;

  const SaveUserIdLocal({required this.repository});

  Future<void> execute(String userId) async{
    repository.saveUserIdToLocal(userId);
  }
}
