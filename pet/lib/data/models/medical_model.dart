
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/domain/entities/medical_entity.dart';

class MedicalModel extends MedicalEntity {
  final String activity;
  final Timestamp expiredDate;
  final String location;
  final String description;
  final Timestamp timeNow;

  MedicalModel(
      {
        // required this.medicalId,
        required this.activity,
        required this.expiredDate,
        required this.location,
        required this.description,
      required this.timeNow})
      : super(
      activity: activity,
      expiredDate: expiredDate,
      location: location,
      description: description,
      timeNow: timeNow
      // medicalId: medicalId
      );

  Map<String, dynamic> toDocument() {
    return {
      // 'medicalId': medicalId,
      'activity': activity,
      'expiredDate': expiredDate,
      'location': location,
      'description': description,
      'timeNow': timeNow
    };
  }
  factory MedicalModel.fromSnapshot(DocumentSnapshot documentSnapshot){
    return MedicalModel(
        // medicalId:  documentSnapshot.get("medicalId"),
        activity: documentSnapshot.get("activity"),
        expiredDate: documentSnapshot.get("expiredDate"),
        location: documentSnapshot.get("location"),
        description: documentSnapshot.get("description"),
        timeNow: documentSnapshot.get("timeNow")
    );

  }

  @override
  List<Object?> get props => [
    // medicalId,
    activity,
    expiredDate,
    location,
    description,
    timeNow
  ];
}
