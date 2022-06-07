part of 'get_medical_bloc.dart';

abstract class GetMedicalEvent extends Equatable {
  const GetMedicalEvent();
  @override
  List<Object> get props => [];
}


class FetchListMedical extends GetMedicalEvent{
  final List<MedicalEntity> listMedical;

  FetchListMedical({required this.listMedical});

  @override
  List<Object> get props => [listMedical];
}
class GetListMedical extends GetMedicalEvent{

}
