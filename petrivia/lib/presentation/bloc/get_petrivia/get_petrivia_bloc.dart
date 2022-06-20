import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:petrivia/domain/usecases/get_petrivia_usecase.dart';

part 'get_petrivia_event.dart';
part 'get_petrivia_state.dart';

class GetPetriviaBloc extends Bloc<GetPetriviaEvent, GetPetriviaState> {
  final GetPetriviaUsecase getPetriviaUsecase;
  GetPetriviaBloc(
      {required this.getPetriviaUsecase})
      : super(GetPetriviaInitial()) {
    on<GetListPetriviaEvent>(
      (event, emit) {
        emit(GetPetriviaSuccess(listPetrivia: event.listPetrivia));
      },
    );
    on<FetchListPetriviaEvent>(
      (event, emit) {
        emit(GetPetriviaLoading());
        try {
          getPetriviaUsecase.execute().listen((petrivia) {
            add(GetListPetriviaEvent(listPetrivia: petrivia));
          });
        } catch (_) {
          emit(GetPetriviaError(message: 'Error Load Data'));
        }
      },
    );
    on<FetchSearchPetriviaEvent>(
      (event, emit) {
        emit(GetPetriviaLoading());
        try {
          getPetriviaUsecase.execute().listen((petrivia) {
            add(GetSearchPetriviaEvent(
                listPetrivia: petrivia, query: event.query));
          });
        } catch (_) {
          emit(GetPetriviaError(message: 'Error Load Data'));
        }
      },
    );
    on<GetSearchPetriviaEvent>(
      (event, emit) {
        List<PetriviaEntity> result = [];
        for (var item in event.listPetrivia) {
          if (item.title!.toLowerCase().contains(event.query.toLowerCase())) {
            result.add(item);
          }
        }
        emit(GetPetriviaSuccess(listPetrivia: result));
      },
    );
  }
}
