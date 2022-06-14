

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/domain/entities/medical_entity.dart';

class GetPetMedicalModel extends GetPetMedicalEntity{
  final String? medical_id;
  final String? activity;
  final Timestamp? expired_date;
  final String? location;
  final String? description;
  final Timestamp? time_publish;
  final String? pet_id;
  GetPetMedicalModel(
      { this.medical_id,
        this.pet_id,
       this.activity,
        this.expired_date,
        this.location,
        this.description,
        this.time_publish})
      : super(
      time_publish: time_publish,
      pet_id: pet_id,
      activity: activity,
      expired_date: expired_date,
      location: location,
      description: description,
      medical_id: medical_id);

 Map<String, dynamic> toDocument() {
   return {
     "medical_id": medical_id,
     "activity": activity,
     "description": description,
     "expired_date": expired_date,
     "location": location,
     "pet_id": pet_id,
     "time_publish": time_publish,
   };
 }

 factory GetPetMedicalModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
   return GetPetMedicalModel(
     medical_id: documentSnapshot.get("medical_id"),
     activity: documentSnapshot.get("activity"),
     description: documentSnapshot.get("description"),
     expired_date: documentSnapshot.get("expired_date"),
     location: documentSnapshot.get("location"),
     pet_id: documentSnapshot.get("pet_id"),
     time_publish: documentSnapshot.get("time_publish"),
   );
 }

 @override
 List<Object?> get props => [
   medical_id,
   activity,
   description,
   expired_date,
   location,
   pet_id,
   time_publish
 ];
}