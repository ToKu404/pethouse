import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HabbitEntity extends Equatable {
  final String? id;
  final String? petId;
  final String? activityType;
  final Timestamp? time;
  final String? repeat;
  final String? title;
  final List<String>? dayRepeat;

  const HabbitEntity(
      {this.id,
      required this.petId,
      required this.activityType,
      required this.time,
      required this.title,
      required this.repeat,
      required this.dayRepeat});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        petId,
        activityType,
        time,
        title,
        repeat,
        dayRepeat,
      ];
}
