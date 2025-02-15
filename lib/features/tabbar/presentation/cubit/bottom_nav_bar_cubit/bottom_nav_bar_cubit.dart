import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/presentation/screens/home_screen.dart';
import '/features/more/presentation/screens/more_screen.dart';
import '/features/reservations/presentation/screens/reservations_screen.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState());

  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const ReservationScreen(),
    const MoreScreen(),
  ];

  Future<void> changeCurrentScreen({required int index}) async {
    currentIndex = index;
    emit(BottomNavBarState(index: currentIndex));
  }
}
