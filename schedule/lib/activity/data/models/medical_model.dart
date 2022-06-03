import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/activity/domain/entities/medical_entity.dart';

class MedicalModel extends MedicalEntity {
  final String? petId;
  final String? activity;
  final Timestamp? expiredDate;
  final String location;
  final String description;

  MedicalModel(
      { this.petId,
      required this.activity,
      required this.expiredDate,
      required this.location,
      required this.description})
      : super(
            activity: activity,
            expiredDate: expiredDate,
            location: location,
            description: description,
            petId: petId);

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'expiredDate': expiredDate,
      'location': location,
      'description': description
    };
  }
}
