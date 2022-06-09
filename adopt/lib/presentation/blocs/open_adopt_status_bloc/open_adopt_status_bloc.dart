import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/adopt_enitity.dart';
import '../../../domain/usecases/get_open_adopt_list_usecase.dart';

part 'open_adopt_status_event.dart';
part 'open_adopt_status_state.dart';

class OpenAdoptStatusBloc
    extends Bloc<OpenAdoptStatusEvent, OpenAdoptStatusState> {
  final GetOpenAdoptListUsecase getOpenAdoptList;
  OpenAdoptStatusBloc({required this.getOpenAdoptList})
      : super(ActivityStatusInitial()) {
    on<GetListOpenAdopt>((event, emit) {
      emit(ListOpenAdoptLoaded(adoptList: event.listPet));
    });
    on<FetchListOpenAdopt>(
      (event, emit) async {
        emit(ActivityStatusLoading());
        // final result = await getAllPetListUsecase.e
        try {
          final prefs = await SharedPreferences.getInstance();
          final String? userId = prefs.getString("userId");
          getOpenAdoptList.execute(userId!).listen((adopt) {
            add(GetListOpenAdopt(listPet: adopt));
          });
        } catch (_) {
          emit(ActivityStatusError(message: "error load data"));
        }
      },
    );
  }
}
