part of 'get_medical_bloc.dart';

abstract class GetMedicalState extends Equatable {
  const GetMedicalState();
  @override
  List<Object> get props => [];
}
class GetMedicalInitial extends GetMedicalState {}

class GetMedicalLoading extends GetMedicalState  {}

class GetMedicalError extends GetMedicalState {
  final String message;
  GetMedicalError(this.message);

  @override
  List<Object> get props => [message];
}

class AddPetSucces extends AddPetState {}

@override
class ListMedicalLoaded extends GetMedicalState{
  final List<MedicalEntity> listmedicalEntity;
  ListMedicalLoaded({required this.listmedicalEntity});
}
