import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionDaysCubit extends Cubit<List<int>> {
  SelectionDaysCubit() : super([]);
  List<String> daysOfWork = [];
  List<String> daysValues = [
    "saturday",
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
  ];
  void toggleSelection(int index) {
    List<int> updatedSelection = List.from(state);
    if (updatedSelection.contains(index)) {
      updatedSelection.remove(index);
      daysOfWork.remove(daysValues[index]);
    } else {
      updatedSelection.add(index);
      daysOfWork.add(daysValues[index]);
    }
    log(daysOfWork.toString());
    emit(updatedSelection);
  }

  void showSelected(List<String> days) {
    daysOfWork.clear();
    emit([]);
    List<int> indices = days.map((day) => daysValues.indexOf(day)).toList();

    for (var index in indices) {
      toggleSelection(index);
    }
  }

  void clearSelection() {
    emit([]);
  }
}
