import 'dart:io';

import '../repositories/pet_firebase_repository.dart';

class AddPhotoUseCase{
  final PetFirebaseRepository firebaseRepository;
  AddPhotoUseCase({required this.firebaseRepository});

  Future<String> execute(File imgUrl) async{
    return firebaseRepository.addPhoto(imgUrl);
  }
}