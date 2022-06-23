import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'internet_check_state.dart';

class InternetCheckCubit extends Cubit<InternetCheckState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetCheckCubit() : super(InternetCheckInitial()) {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        onInternetGainedEvent();
      } else {
        onInternetLostEvent();
      }
    });
  }

  Future<void> onInternetLostEvent() async {
    emit(InternetCheckLost());
  }

  Future<void> onInternetGainedEvent() async {
    emit(InternetCheckGain());
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
