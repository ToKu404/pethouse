import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/nofitication_entity.dart';
import '../../../domain/usecases/send_adopt_notif_usecase.dart';

part 'send_notif_event.dart';
part 'send_notif_state.dart';

class SendNotifBloc extends Bloc<SendNotifEvent, SendNotifState> {
  final SendAdoptNotifUsecase sendAdoptNotifUsecase;
  SendNotifBloc({required this.sendAdoptNotifUsecase})
      : super(SendNotifInitial()) {
    on<SendAdoptNotification>(
      (event, emit) async {
        await sendAdoptNotifUsecase.execute(
            event.ownerId, event.notificationEntity);
        emit(SendAdoptNotifSuccess());
      },
    );
  }
}
