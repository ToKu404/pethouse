import 'package:core/services/preference_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/domain/entities/nofitication_entity.dart';
import 'package:notification/domain/usecases/clear_notification_usecase.dart';
import 'package:notification/domain/usecases/get_list_notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetListNotificationUsecase getListNotificationUsecase;
  final PreferenceHelper preferenceHelper;
  final ClearNotificationUsecase clearNotificationUsecase;

  NotificationBloc(
      {required this.getListNotificationUsecase,
      required this.clearNotificationUsecase,
      required this.preferenceHelper})
      : super(NotificationInitial()) {
    on<GetListNotification>((event, emit) {
      emit(NotificationSuccess(
          listNotification: event.listNotification.reversed.toList()));
    });
    on<FetchListNotification>(
      (event, emit) async {
        try {
          String userId = await preferenceHelper.getUserId();
          getListNotificationUsecase.execute(userId).listen((event) {
            add(GetListNotification(listNotification: event));
          });
        } catch (_) {
          emit(NotificationError(message: 'Error Load Data'));
        }
      },
    );
    on<ClearNotification>(
      (event, emit) async {
        try {
          String userId = await preferenceHelper.getUserId();
          await clearNotificationUsecase.execute(userId);
          add(FetchListNotification());
        } catch (_) {
          emit(NotificationError(message: 'Error Load Data'));
        }
      },
    );
  }
}
