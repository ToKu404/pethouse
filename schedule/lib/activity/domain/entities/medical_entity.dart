import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MedicalEntity extends Equatable {
  final String? medicalId;
  final String? activity;
  final Timestamp? expiredDate;
  final String location;
  final String description;
  final Timestamp timeNow;

  MedicalEntity(
      { this.medicalId,
        required this.activity,
      required this.expiredDate,
      required this.location,
      required this.description,
      required this.timeNow});

  @override
  List<Object?> get props => [activity, expiredDate,location,description,timeNow];
}
