import 'package:image_picker/image_picker.dart';

import '../../repositories/user_firebase_repository.dart';

class UploadImageUsecase {
  final FirebaseRepository firebaseRepository;

  UploadImageUsecase({required this.firebaseRepository});

  Future<String> execute(XFile imageFile) {
    return firebaseRepository.uploadImage(imageFile);
  }
}
