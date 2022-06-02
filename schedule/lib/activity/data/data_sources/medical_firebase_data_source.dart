

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/activity/data/models/medical_model.dart';
import 'package:schedule/activity/domain/entities/medical_entity.dart';

abstract class MedicalFirebaseDataSource{
  Future<void> addMedical(MedicalEntity medicalEntity);
}

class MedicalFirebaseDataSourceImpl implements MedicalFirebaseDataSource{
  final FirebaseFirestore medicalFireStore;

  MedicalFirebaseDataSourceImpl({required this.medicalFireStore});

  @override
  Future<void> addMedical(MedicalEntity medicalEntity) async {
    // TODO: implement addPet
    final collectionRef = medicalFireStore.collection('medical');
    final petId = collectionRef.doc().id;


    //mengubah menjadi JSON
    collectionRef.doc(petId).get().then((value) {
      final newMedical = MedicalModel(
          petId: petId,
          activity: medicalEntity.activity,
          expiredDate: medicalEntity.expiredDate,
          description: medicalEntity.description,
          location: medicalEntity.location
      ).toJson();
      if (!value.exists) {
        collectionRef.doc(petId).set(newMedical);
      }
      return;
    });
  }
}