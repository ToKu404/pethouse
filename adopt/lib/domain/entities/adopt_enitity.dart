import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdoptEntity extends Equatable {
  final String? adoptId;
  final String? userId;
  final String? petName;
  final String? petType;
  final String? petPictureUrl;
  final String? gender;
  final String? petBreed;
  final Timestamp? dateOfBirth;
  final String? certificateUrl;
  final String? whatsappNumber;
  final String? petDescription;
  final String? status;
  final String? adopterId;
  final String? adopterName;
  final List<String>? titleSearch;

  const AdoptEntity({
    this.adoptId,
    this.userId,
    required this.petName,
    required this.petType,
    this.petPictureUrl,
    required this.gender,
    this.petBreed,
    this.dateOfBirth,
    this.certificateUrl,
    this.whatsappNumber,
    this.petDescription,
    required this.status,
    this.adopterId,
    this.adopterName,
    this.titleSearch,
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
        whatsappNumber,
        adoptId,
        userId,
        petDescription,
        status,
        adopterId,
        adopterName,
        titleSearch
      ];
}

enum Gender { male, female }
