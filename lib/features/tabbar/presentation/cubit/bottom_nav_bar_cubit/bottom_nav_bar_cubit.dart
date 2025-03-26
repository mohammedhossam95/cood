import 'package:cood/features/categories/presentation/screens/categories_screen.dart';
import 'package:cood/features/discover/presentation/screens/discover_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/presentation/screens/home_screen.dart';
import '../../../../profile/presentation/screens/more_screen.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState());

  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    DiscoverScreen(),
    const CategoriesScreen(),
    const MoreScreen(),
  ];

  Future<void> changeCurrentScreen({required int index}) async {
    currentIndex = index;
    emit(BottomNavBarState(index: currentIndex));
  }
}
