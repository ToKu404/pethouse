import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/domain/usecases/get_pet_desc_usecase.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:schedule/domain/use_cases/get_today_task_usecase.dart';

part 'get_pet_desc_event.dart';
part 'get_pet_desc_state.dart';

class GetPetDescBloc extends Bloc<GetPetDescEvent, GetPetDescState> {
  final GetPetDescUsecase getPetDescUsecase;
  final GetTodayTaskUsecase getTodayTaskUsecase;
  GetPetDescBloc(
      {required this.getPetDescUsecase, required this.getTodayTaskUsecase})
      : super(PetDescInitial()) {
    on<GetPetDesc>(
      (event, emit) async {
        getTodayTaskUsecase
            .execute(event.petEntity.id!, DateTime.now())
            .listen((result) {
          add(GetPetTodayTask(petEntity: event.petEntity, listTask: result));
        });
        // emit(PetDescSuccess(petEntity: event.petEntity));
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
    on<GetPetTodayTask>(
      (event, emit) {
        emit(PetDescSuccess(
            petEntity: event.petEntity, listTask: event.listTask));
      },
    );
  }
}
