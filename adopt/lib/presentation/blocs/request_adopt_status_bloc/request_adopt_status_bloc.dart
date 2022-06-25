import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/domain/usecases/get_request_adopt_list_usecase.dart';
import 'package:core/services/preference_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_adopt_status_event.dart';
part 'request_adopt_status_state.dart';

class RequestAdoptStatusBloc
    extends Bloc<RequestAdoptStatusEvent, RequestAdoptStatusState> {
  final GetRequestAdoptListUsecase getRequestAdoptList;
  final PreferenceHelper preferenceHelper;
  RequestAdoptStatusBloc({required this.getRequestAdoptList, required this.preferenceHelper}) : super(RequestAdoptStatusInitial()) {
    on<GetListRequestAdopt>((event, emit) {
      emit(ListRequestAdoptLoaded(adoptList: event.listPet));
    });
    on<FetchListRequestAdopt>(
      (event, emit) async {
        emit(RequestAdoptStatusLoading());
        try {
          final userId = await preferenceHelper.getUserId();
          getRequestAdoptList.execute(userId).listen((adopt) {
            add(GetListRequestAdopt(listPet: adopt));
          });
        } catch (_) {
          emit(RequestAdoptStatusError(message: "error load data"));
        }
      },
    );
  }
}
