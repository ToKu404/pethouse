import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MedicalEntity extends Equatable {
  final String? petId;
  final String? activity;
  final Timestamp? expiredDate;
  final String location;
  final String description;

  MedicalEntity(
      { this.petId,
        required this.activity,
      required this.expiredDate,
      required this.location,
      required this.description});

  @override
  List<Object?> get props => [activity, expiredDate,location,description];
}
