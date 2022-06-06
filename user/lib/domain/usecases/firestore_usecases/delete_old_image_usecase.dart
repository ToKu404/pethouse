import '../../repositories/user_repository.dart';

class DeleteOldImageUsecase {
  final UserRepository firebaseRepository;

  const DeleteOldImageUsecase(this.firebaseRepository);

  Future<void> execute(String oldImageUrl) {
    return firebaseRepository.deleteOldImage(oldImageUrl);
  }
}
