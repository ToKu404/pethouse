
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/domain/entities/nofitication_entity.dart';
import 'package:notification/domain/usecases/get_list_notification_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetListNotificationUsecase getListNotificationUsecase;

  NotificationBloc({
    required this.getListNotificationUsecase,
  }) : super(NotificationInitial()) {
    on<GetListNotification>((event, emit) {
      emit(NotificationSuccess(listNotification: event.listNotification));
    });
    on<FetchListNotification>(
      (event, emit) async {
        try {
          emit(NotificationLoading());
          final prefs = await SharedPreferences.getInstance();
          final String? userId = prefs.getString("userId");
          getListNotificationUsecase.execute(userId!).listen((event) {
            add(GetListNotification(listNotification: event));
          });
        } catch (_) {
          emit(NotificationError(message: 'Error Load Data'));
        }
      },
    );
  }
}
