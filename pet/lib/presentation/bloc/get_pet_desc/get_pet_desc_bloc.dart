import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/usecases/get_pet_desc_usecase.dart';

part 'get_pet_desc_event.dart';
part 'get_pet_desc_state.dart';

class GetPetDescBloc extends Bloc<GetPetDescEvent, GetPetDescState> {
  final GetPetDescUsecase getPetDescUsecase;
  GetPetDescBloc({required this.getPetDescUsecase}) : super(PetDescInitial()) {
    on<GetPetDesc>(
      (event, emit) async {
        emit(PetDescSuccess(petEntity: event.petEntity));
      },
    );
    on<FetchPetDesc>(
      (event, emit) {
        emit(PetDescLoading());
        try {
          getPetDescUsecase.execute(event.petId).listen((event) {
            add(GetPetDesc(petEntity: event));
          });
        } catch (_) {
          emit(PetDescError(message: "error load data"));
        }
      },
    );
  }
}
