

import '../../repositories/user_firebase_repository.dart';

class GetUserIdUsecase {
  final FirebaseRepository firebaseRepository;

  GetUserIdUsecase({required this.firebaseRepository});

  Future<String> execute() async {
    return firebaseRepository.retrieveUid();
  }
}
