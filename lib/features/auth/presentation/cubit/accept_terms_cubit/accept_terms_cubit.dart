import 'package:bloc/bloc.dart';

class AcceptTermsCubit extends Cubit<bool> {
  AcceptTermsCubit() : super(false);
  toggleCheckbox() {
    emit(!state);
  }
}
