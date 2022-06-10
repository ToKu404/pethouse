import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/pet_entity.dart';
import '../../../domain/usecases/get_pets_usecase.dart';

part 'get_schedule_pet_event.dart';
part 'get_schedule_pet_state.dart';

class GetSchedulePetBloc
    extends Bloc<GetSchedulePetEvent, GetSchedulePetState> {
  final GetPetsUsecase getPetUsecase;

  GetSchedulePetBloc({required this.getPetUsecase})
      : super(GetSchedulePetInitial()) {
    on<GetScheduleListPet>((event, emit) {
      emit(GetSchedulePetSuccess(listPet: event.listPet));
    });
    on<FetchListSchedulePet>(
      (event, emit) async {
        emit(GetSchedulePetLoading());
        // final result = await getPetUsecase.e
        try {
          final prefs = await SharedPreferences.getInstance();
          final String? userId = prefs.getString("userId");
          getPetUsecase.execute(userId!).listen((adopt) {
            add(GetScheduleListPet(listPet: adopt));
          });
        } catch (_) {
          emit(GetSchedulePetError(message: "error load data"));
        }
      },
    );
  }
}
