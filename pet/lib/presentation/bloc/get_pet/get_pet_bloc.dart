import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/usecases/get_pets_usecase.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_pet_event.dart';
part 'get_pet_state.dart';

class GetPetBloc extends Bloc<GetPetEvent, GetPetState> {
  final GetPetsUsecase getPetUsecase;
  GetPetBloc({required this.getPetUsecase}) : super(GetPetInitial()) {
    on<GetListPet>((event, emit) {
      emit(GetPetSuccess(listPet: event.listPet));
    });
    on<FetchListPet>(
      (event, emit) async {
        emit(GetPetLoading());
        // final result = await getPetUsecase.e
        try {
          final prefs = await SharedPreferences.getInstance();
          final String? userId = prefs.getString("userId");
          getPetUsecase.execute(userId!).listen((adopt) {
            add(GetListPet(listPet: adopt));
          });
        } catch (_) {
          emit(GetPetError(message: "error load data"));
        }
      },
    );
  }
}
