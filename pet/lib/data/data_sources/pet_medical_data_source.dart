

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet/data/models/medical_model.dart';
import 'package:pet/domain/entities/medical_entity.dart';

abstract class PetMedicalDataSource{
  Stream<List<GetPetMedicalEntity>> getPetMedical(String pet_id);
}

class PetMedicalDataSourceImpl implements PetMedicalDataSource{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  PetMedicalDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});

  @override
  Stream<List<GetPetMedicalEntity>> getPetMedical(String pet_id) {
    final petCollection = firebaseFirestore
        .collection('medical')
        .where('pet_id', isEqualTo: pet_id);
    return petCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => GetPetMedicalModel.fromSnapshot(docSnap))
          .toList();
    });
  }
  
}

