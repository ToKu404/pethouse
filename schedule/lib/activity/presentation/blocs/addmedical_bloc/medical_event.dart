part of 'medical_bloc.dart';

abstract class MedicalEvent extends Equatable {
  const MedicalEvent();

  @override
  List<Object> get props => [];

}

class CreateMedical extends MedicalEvent{
  final MedicalEntity medicalEntity;
  CreateMedical({required this.medicalEntity});
  @override
  List<Object> get props => [medicalEntity];
}
