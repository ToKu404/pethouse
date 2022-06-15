import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/medical_entity.dart';
import '../../../domain/use_cases/get_pet_medical_usecase.dart';

part 'get_pet_medical_event.dart';
part 'get_pet_medical_state.dart';

class GetPetMedicalBloc extends Bloc<GetPetMedicalEvent, GetPetMedicalState> {
  final GetPetMedicalUsecase getPetMedicalUsecase;
  GetPetMedicalBloc({required this.getPetMedicalUsecase}) : super(GetPetMedicalInitial()) {
    on<GetListPetMedical>((event, emit) {
      emit(GetPetMedicalSucces(listPetMedical: event.listPetMedical));
    });
    on<FetchListPetMedical>(
          (event, emit) async {
        emit(GetPetMedicalLoading());
        try {
          getPetMedicalUsecase.execute(event.petId).listen((medical) {
            add(GetListPetMedical(listPetMedical: medical));
          });
        } catch (_) {
          emit(GetPetMedicalError(message: "error load data"));
        }
      },
    );
  }
}