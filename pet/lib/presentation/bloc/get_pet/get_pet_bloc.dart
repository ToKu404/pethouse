import 'package:core/services/preference_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/usecases/get_pets_usecase.dart';

part 'get_pet_event.dart';
part 'get_pet_state.dart';

class GetPetBloc extends Bloc<GetPetEvent, GetPetState> {
  final GetPetsUsecase getPetUsecase;
  final PreferenceHelper preferenceHelper;
  GetPetBloc({required this.getPetUsecase, required this.preferenceHelper})
      : super(GetPetInitial()) {
    on<GetListPet>((event, emit) {
      emit(GetPetSuccess(listPet: event.listPet));
    });
    on<FetchListPet>(
      (event, emit) async {
        emit(GetPetLoading());
        // final result = await getPetUsecase.e
        try {
          final userId = await preferenceHelper.getUserId();
          getPetUsecase.execute(userId).listen((adopt) {
            add(GetListPet(listPet: adopt));
          });
        } catch (_) {
          emit(GetPetError(message: "error load data"));
        }
      },
    );
  }
}
