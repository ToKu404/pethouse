import 'package:image_picker/image_picker.dart';

import '../../repositories/user_repository.dart';

class UploadImageUsecase {
  final UserRepository firebaseRepository;

  UploadImageUsecase({required this.firebaseRepository});

  Future<String> execute(XFile imageFile) {
    return firebaseRepository.uploadImage(imageFile);
  }
}
