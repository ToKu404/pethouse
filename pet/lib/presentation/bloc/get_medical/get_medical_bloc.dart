import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet/domain/entities/medical_entity.dart';
import 'package:pet/domain/usecases/get_medical_usecase.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';

part 'get_medical_event.dart';
part 'get_medical_state.dart';

class GetMedicalBloc extends Bloc<GetMedicalEvent, GetMedicalState> {
  final GetAllMedicalUsecase getAllMedicalUsecase;

  GetMedicalBloc({required this.getAllMedicalUsecase}) : super(GetMedicalInitial()) {
    on<FetchListMedical>((event, emit) {
      emit(ListMedicalLoaded(listmedicalEntity: event.listMedical));
    });
    on<GetListMedical>(
          (event, emit) async {
        emit(GetMedicalLoading ());
        try {
          getAllMedicalUsecase.execute().listen((medical) {
            add(FetchListMedical(listMedical: medical,));
          });
        } catch (_) {
          emit(GetMedicalError("error pada data"));
        }
      },
    );
  }
}
