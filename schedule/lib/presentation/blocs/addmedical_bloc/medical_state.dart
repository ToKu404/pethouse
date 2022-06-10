part of 'medical_bloc.dart';

abstract class MedicalState extends Equatable {
  const MedicalState();
  @override
  List<Object> get props => [];
}

class MedicalInitial extends MedicalState {

}

class MedicalLoading extends MedicalState{

}

class MedicalError extends MedicalState{
  final String message;
  MedicalError(this.message);

  @override
  List<Object> get props =>[message];

}

class MedicalSucces extends MedicalState{

}