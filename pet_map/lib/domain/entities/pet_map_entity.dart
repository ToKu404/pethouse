import 'package:equatable/equatable.dart';

class PetMapEntity extends Equatable {
  final String? id;
  final String? name;
  final String? petPhotoUrl;
  final double? latitude;
  final double? longitude;

  const PetMapEntity(
      {this.id,
      this.petPhotoUrl,
      required this.latitude,
      required this.longitude,
      this.name});

  @override
  List<Object?> get props => [id, petPhotoUrl, latitude, longitude, name];
}
