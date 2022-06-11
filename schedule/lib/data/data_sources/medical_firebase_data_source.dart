

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
    final medical_id = collectionRef.doc().id;


    //mengubah menjadi JSON
    collectionRef.doc(medical_id).get().then((value) {
      final newMedical = MedicalModel(
          time_publish: medicalEntity.time_publish,
          medical_id: medical_id,
          activity: medicalEntity.activity,
          expired_date: medicalEntity.expired_date,
          description: medicalEntity.description,
          location: medicalEntity.location,
          pet_id: medicalEntity.pet_id
      ).toJson();
      if (!value.exists) {
        collectionRef.doc(medical_id).set(newMedical);
      }
      return;
    });
  }
}