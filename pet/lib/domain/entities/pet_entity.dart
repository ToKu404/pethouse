import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String? petId;
  final String? imgUrl;
  final String? petType;
  final String? name;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? breed;
  final String fileUrl;
  final String description;

  PetEntity(
      { this.petId,
        required this.imgUrl,
        required this.petType,
        required this.name,
        required this.gender,
        required this.dateOfBirth,
        required this.breed,
        required this.fileUrl,
        required this.description});

  @override
  List<Object?> get props => [imgUrl, petType, name, gender, dateOfBirth, breed, fileUrl, description];
}