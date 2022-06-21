import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/use_cases/get_all_habbits_usecases.dart';
import '../../../domain/entities/habbit_entity.dart';

part 'get_habbit_event.dart';
part 'get_habbit_state.dart';

class GetHabbitBloc extends Bloc<GetHabbitEvent, GetHabbitState> {
  final GetAllHabbitsUsecase getHabbitUsecase;
  GetHabbitBloc({required this.getHabbitUsecase}) : super(GetHabbitInitial()) {
    on<GetHabbits>(
      (event, emit) {
        emit(GetHabbitSuccess(listHabbit: event.listHabbit));
      },
    );
    on<FetchHabbits>(
      (event, emit) {
        emit(GetHabbitLoading());
        try {
          getHabbitUsecase.execute(event.petId).listen((task) {
            add(GetHabbits(listHabbit: task));
          });
        } catch (_) {
          emit(GetHabbitError(message: "error load data"));
        }
      },
    );
  }
}
