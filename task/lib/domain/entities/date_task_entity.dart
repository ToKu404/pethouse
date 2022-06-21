import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DateTaskEntity extends Equatable {
  final String? id;
  final String? date;
  final String? petId;
  final List<String>? listTaskId;

  DateTaskEntity(
      {this.id,
      required this.date,
      required this.petId,
      required this.listTaskId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, date, petId, listTaskId];
}
