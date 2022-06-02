

import 'package:schedule/activity/domain/entities/medical_entity.dart';

abstract class MedicalFirebaseRepository{
  Future<void> addMedical(MedicalEntity medicalEntity);
}