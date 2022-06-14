import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GetPetMedicalEntity extends Equatable {
  final String? medical_id;
  final String? activity;
  final Timestamp? expired_date;
  final String? location;
  final String? description;
  final Timestamp? time_publish;
  final String? pet_id;

  GetPetMedicalEntity({
    this.medical_id,
    this.activity,
    this.expired_date,
    this.location,
    this.description,
    this.time_publish,
    this.pet_id,
  });

  @override
  List<Object?> get props => [
        medical_id,
        activity,
        expired_date,
        location,
        description,
        time_publish,
        pet_id
      ];
}
