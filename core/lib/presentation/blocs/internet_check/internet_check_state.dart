part of 'internet_check_cubit.dart';

abstract class InternetCheckState {}

class InternetCheckInitial extends InternetCheckState {}

class InternetCheckLoading extends InternetCheckState {}

class OnetimeCheckLost extends InternetCheckState {}

class OnetimeCheckGain extends InternetCheckState {}

class RealtimeCheckLost extends InternetCheckState {}

class RealtimeCheckGain extends InternetCheckState {}