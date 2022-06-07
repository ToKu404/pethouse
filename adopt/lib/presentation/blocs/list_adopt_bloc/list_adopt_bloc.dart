
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/entities/adopt_enitity.dart';
import '../../../domain/usecases/get_all_pet_list_usecase.dart';

part 'list_adopt_event.dart';
part 'list_adopt_state.dart';

class ListAdoptBloc extends Bloc<ListAdoptEvent, ListAdoptState> {
   final GetAllPetListUsecase getAllPetListUsecase;
  ListAdoptBloc({required this.getAllPetListUsecase}) : super(ListAdoptInitial()) {
    on<GetListPetAdopt>((event, emit) {
      emit(ListPetAdoptLoaded(listAdoptEntity: event.listPet));
    });
    on<FetchListPetAdopt>(
      (event, emit) async {
        emit(ListAdoptLoading());
        try {
          getAllPetListUsecase.execute().listen((adopt) {
            add(GetListPetAdopt(listPet: adopt));
          });
        } catch (_) {
          emit(ListAdoptError(message: "error load data"));
        }
      },
    );
  }
}
