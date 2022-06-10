import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? petName;
  final String? petType;
  final String? petPictureUrl;
  final String? gender;
  final String? petBreed;
  final Timestamp? dateOfBirth;
  final String? certificateUrl;
  final String? petDescription;

  const PetEntity({
    this.id,
    this.userId,
    required this.petName,
    required this.petType,
    this.petPictureUrl,
    required this.gender,
    this.petBreed,
    this.dateOfBirth,
    this.certificateUrl,
    this.petDescription,
  });

  @override
  List<Object?> get props => [
        petName,
        petPictureUrl,
        gender,
        petType,
        petBreed,
        dateOfBirth,
        certificateUrl,
        id,
        userId,
        petDescription,
      ];
}
enum Gender { male, female }
