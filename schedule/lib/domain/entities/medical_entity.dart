import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MedicalEntity extends Equatable {
  final String? medical_id;
  final String? activity;
  final Timestamp? expired_date;
  final String location;
  final String description;
  final Timestamp time_publish;
  final String? pet_id;

  MedicalEntity(
      { this.pet_id,
        this.medical_id,
        required this.activity,
      required this.expired_date,
      required this.location,
      required this.description,
      required this.time_publish});

  @override
  List<Object?> get props => [activity, expired_date,location,description,time_publish];
}
