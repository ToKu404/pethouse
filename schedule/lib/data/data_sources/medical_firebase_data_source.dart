

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/data/models/medical_model.dart';
import 'package:schedule/domain/entities/medical_entity.dart';

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
    final medicalId = collectionRef.doc().id;


    //mengubah menjadi JSON
    collectionRef.doc(medicalId).get().then((value) {
      final newMedical = MedicalModel(
          timeNow: medicalEntity.timeNow,
          medicalId: medicalId,
          activity: medicalEntity.activity,
          expiredDate: medicalEntity.expiredDate,
          description: medicalEntity.description,
          location: medicalEntity.location
      ).toJson();
      if (!value.exists) {
        collectionRef.doc(medicalId).set(newMedical);
      }
      return;
    });
  }
}