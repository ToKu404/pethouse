import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/data/models/pet_model.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/pages/add_pet.dart';

abstract class PetFirebaseDataSource {
  Future<void> addPet(PetEntity petEntity);
  Future<String> addPhoto(File imgUrl);
}

class PetFirebaseDataSourceImpl implements PetFirebaseDataSource {
  final FirebaseFirestore petFireStore;
  final FirebaseStorage firebaseStorage;

  PetFirebaseDataSourceImpl(
      {required this.petFireStore, required this.firebaseStorage});

  @override
  Future<void> addPet(PetEntity petEntity) async {
    // TODO: implement addPet
    final collectionRef = petFireStore.collection('pet');
    final petId = collectionRef.doc().id;

    //mengubah menjadi JSON
    collectionRef.doc(petId).get().then((value) {
      final newPet = PetModel(
              petId: petId,
              imgUrl: petEntity.imgUrl,
              name: petEntity.name,
              gender: petEntity.gender,
              dateOfBirth: petEntity.dateOfBirth,
              breed: petEntity.breed,
              fileUrl: petEntity.fileUrl,
              description: petEntity.description)
          .toJson();
      if (!value.exists) {
        collectionRef.doc(petId).set(newPet);
      }
      return;
    });
  }

  @override
  Future<String> addPhoto(File imgUrl) async {
    // TODO: implement addPhoto
    String imgName = basename(imgUrl.path);
    final ref = firebaseStorage.ref().child('petPhoto').child(imgName);
    await ref.putFile(imgUrl);

    return await ref.getDownloadURL();
  }
}
