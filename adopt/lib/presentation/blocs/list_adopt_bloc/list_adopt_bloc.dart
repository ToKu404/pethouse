import 'package:adopt/domain/usecases/search_pet_adopt_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/adopt_enitity.dart';
import '../../../domain/usecases/get_all_pet_list_usecase.dart';

part 'list_adopt_event.dart';
part 'list_adopt_state.dart';

class ListAdoptBloc extends Bloc<ListAdoptEvent, ListAdoptState> {
  final GetAllPetListUsecase getAllPetListUsecase;
  final SearchPetAdoptUsecase searchPetAdoptUsecase;
  ListAdoptBloc(
      {required this.getAllPetListUsecase, required this.searchPetAdoptUsecase})
      : super(ListAdoptInitial()) {
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
    on<FetchSearchPetAdopt>(
      (event, emit) async {
        emit(ListAdoptLoading());
        String query = event.query.toLowerCase();
        try {
          searchPetAdoptUsecase.execute(query).listen((adopt) {
            add(GetListPetAdopt(listPet: adopt));
          });
        } catch (_) {
          emit(ListAdoptError(message: "error load data"));
        }
      },
    );
  }
}
