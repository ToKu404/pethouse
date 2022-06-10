
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule/domain/entities/medical_entity.dart';
import 'package:schedule/domain/use_cases/medicaladd_usecase.dart';


part 'medical_event.dart';
part 'medical_state.dart';

class MedicalBloc extends Bloc<MedicalEvent, MedicalState> {
  final AddMedicalUseCase addMedicalUsecase;


  MedicalBloc({required this.addMedicalUsecase}) : super(MedicalInitial()) {
    on<CreateMedical>((event, emit) async {
      // TODO: implement event handler
      emit(MedicalLoading());
      await addMedicalUsecase.execute(event.medicalEntity);
      emit(MedicalSucces());

    });
  }
}
