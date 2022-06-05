import 'dart:io';

import '../repositories/pet_firebase_repository.dart';

class AddCertificateUseCase {
  final PetFirebaseRepository firebaseRepository;
  AddCertificateUseCase({required this.firebaseRepository});

  Future<String> execute(File ctfUrl) async {
    return firebaseRepository.addCertificate(ctfUrl);
  }
}
