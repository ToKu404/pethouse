import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet/domain/entities/medical_entity.dart';
import 'package:pet/domain/usecases/get_pet_medical_usecase.dart';
import 'package:pet/presentation/bloc/get_pet/get_pet_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          final prefs = await SharedPreferences.getInstance();
          final String? pet_id = prefs.getString("pet_id");
          getPetMedicalUsecase.execute(pet_id!).listen((medical) {
            add(GetListPetMedical(listPetMedical: medical));
          });
        } catch (_) {
          emit(GetPetMedicalError(message: "error load data"));
        }
      },
    );
  }
}
