import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_db_event.dart';
part 'user_db_state.dart';

class UserDbBloc extends Bloc<UserDbEvent, UserDbState> {
  UserDbBloc() : super(UserDbInitial()) {
    on<UserDbEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
