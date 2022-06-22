import 'package:core/services/preference_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/pet_entity.dart';
import '../../../domain/usecases/get_pets_usecase.dart';

part 'get_schedule_pet_event.dart';
part 'get_schedule_pet_state.dart';

class GetSchedulePetBloc
    extends Bloc<GetSchedulePetEvent, GetSchedulePetState> {
  final GetPetsUsecase getPetUsecase;
  final PreferenceHelper preferenceHelper;

  GetSchedulePetBloc(
      {required this.getPetUsecase, required this.preferenceHelper})
      : super(GetSchedulePetInitial()) {
    on<GetScheduleListPet>((event, emit) {
      emit(GetSchedulePetSuccess(listPet: event.listPet));
    });
    on<FetchListSchedulePet>(
      (event, emit) async {
        emit(GetSchedulePetLoading());
        try {
          String userId = await preferenceHelper.getUserId();
          getPetUsecase.execute(userId).listen((adopt) {
            add(GetScheduleListPet(listPet: adopt));
          });
        } catch (_) {
          emit(GetSchedulePetError(message: "error load data"));
        }
      },
    );
  }
}
