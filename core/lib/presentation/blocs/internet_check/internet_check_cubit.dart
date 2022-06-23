import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'internet_check_state.dart';

class InternetCheckCubit extends Cubit<InternetCheckState> {
  StreamSubscription? connectivitySubscription;
  InternetCheckCubit() : super(InternetCheckInitial());

  Future<void> onCheckConnectionRealtime() async {
    final Connectivity connectivity = Connectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        emit(RealtimeCheckGain());
      } else {
        emit(RealtimeCheckLost());
      }
    });
  }

  Future<void> onCheckConnectionOnetime() async {
    final Connectivity connectivity = Connectivity();
    emit(InternetCheckLoading());
    var result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      emit(OnetimeCheckGain());
    } else {
      emit(OnetimeCheckLost());
    }
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
