part of 'bottom_nav_bar_cubit.dart';

class BottomNavBarState extends Equatable {
  final int index;

  const BottomNavBarState({
    this.index = 0,
  });

  @override
  List<Object?> get props => [
    index,
  ];
}