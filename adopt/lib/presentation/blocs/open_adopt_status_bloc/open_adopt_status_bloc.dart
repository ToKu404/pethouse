import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/adopt_enitity.dart';
import '../../../domain/usecases/get_open_adopt_list_usecase.dart';

part 'open_adopt_status_event.dart';
part 'open_adopt_status_state.dart';

class OpenAdoptStatusBloc
    extends Bloc<OpenAdoptStatusEvent, OpenAdoptStatusState> {
  final GetOpenAdoptListUsecase getOpenAdoptList;
  final PreferenceHelper preferenceHelper;
  OpenAdoptStatusBloc(
      {required this.getOpenAdoptList, required this.preferenceHelper})
      : super(ActivityStatusInitial()) {
    on<GetListOpenAdopt>((event, emit) {
      emit(ListOpenAdoptLoaded(adoptList: event.listPet));
    });
    on<FetchListOpenAdopt>(
      (event, emit) async {
        emit(ActivityStatusLoading());
        try {
          final userId = await preferenceHelper.getUserId();
          getOpenAdoptList.execute(userId).listen((adopt) {
            add(GetListOpenAdopt(listPet: adopt));
          });
        } catch (_) {
          emit(ActivityStatusError(message: "error load data"));
        }
      },
    );
  }
}
