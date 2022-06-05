import 'package:pet/domain/entities/pet_entity.dart';

class PetModel extends PetEntity {
  final String? petId;
  final String? imgUrl;
  final String? petType;
  final String? name;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? breed;
  final String fileUrl;
  final String description;

  PetModel(
      {this.petId,
      required this.imgUrl,
      required this.petType,
      required this.name,
      required this.gender,
      required this.dateOfBirth,
      required this.breed,
      required this.fileUrl,
      required this.description})
      : super(
          petId: petId,
          imgUrl: imgUrl,
          petType: petType,
          name: name,
          gender: gender,
          dateOfBirth: dateOfBirth,
          breed: breed,
          fileUrl: fileUrl,
          description: description,
        );

  Map<String, dynamic> toJson() {
    return {
      'Img Url': imgUrl,
      'Pet Type': petType,
      'Name': name,
      'Gender': gender,
      'Date Of Birth': dateOfBirth,
      'Breed': breed,
      'File Url': fileUrl,
      'Description': description
    };
  }
}
