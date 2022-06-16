import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:petrivia/domain/entities/petrivia_entity.dart';
import 'package:petrivia/domain/usecases/get_petrivia_usecase.dart';

part 'get_petrivia_event.dart';
part 'get_petrivia_state.dart';

class GetPetriviaBloc extends Bloc<GetPetriviaEvent, GetPetriviaState> {
  final GetPetriviaUsecase getPetriviaUsecase;
  GetPetriviaBloc({required this.getPetriviaUsecase})
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
  }
}
