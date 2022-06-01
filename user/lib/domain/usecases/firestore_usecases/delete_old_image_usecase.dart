

import '../../repositories/user_firebase_repository.dart';

class DeleteOldImageUsecase {
  final FirebaseRepository firebaseRepository;

  const DeleteOldImageUsecase(this.firebaseRepository);

  Future<void> execute(String oldImageUrl) {
    return firebaseRepository.deleteOldImage(oldImageUrl);
  }
}
