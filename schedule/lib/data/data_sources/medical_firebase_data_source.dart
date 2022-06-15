

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/data/models/medical_model.dart';
import 'package:schedule/domain/entities/medical_entity.dart';

abstract class MedicalFirebaseDataSource{
  Future<void> addMedical(MedicalEntity medicalEntity);
  Stream<List<MedicalEntity>> getPetMedical(String pet_id);
}

class MedicalFirebaseDataSourceImpl implements MedicalFirebaseDataSource{
  final FirebaseFirestore medicalFireStore;

  MedicalFirebaseDataSourceImpl({required this.medicalFireStore});

  @override
  Future<void> addMedical(MedicalEntity medicalEntity) async {
    final collectionRef = medicalFireStore.collection('medicals');
    final medicalId = collectionRef.doc().id;

    //mengubah menjadi JSON
    collectionRef.doc(medicalId).get().then((value) {
      final newMedical = MedicalModel(
          time_publish: medicalEntity.time_publish,
          medical_id: medicalId,
          activity: medicalEntity.activity,
          expired_date: medicalEntity.expired_date,
          description: medicalEntity.description,
          location: medicalEntity.location,
          pet_id: medicalEntity.pet_id
      ).toJson();
      if (!value.exists) {
        collectionRef.doc(medicalId).set(newMedical);
      }
      return;
    });
  }
  
  @override
  Stream<List<MedicalEntity>> getPetMedical(String petId) {
    final petCollection = medicalFireStore
        .collection('medicals')
        .where('pet_id', isEqualTo: petId);
    return petCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => MedicalModel.fromSnapshot(docSnap))
          .toList();
    });
  }
}