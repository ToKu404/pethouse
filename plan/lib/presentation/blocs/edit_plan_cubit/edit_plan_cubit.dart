import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_plan_state.dart';

class EditPlanCubit extends Cubit<EditPlanState> {
  EditPlanCubit() : super(EditPlanInitial());
}
