import 'package:equatable/equatable.dart';

class PlansStatusEntity extends Equatable {
  final bool? weekly;
  final bool? daily;
  final bool? monthly;

  const PlansStatusEntity({
    this.weekly,
    this.daily,
    this.monthly,
  });

  @override
  List<Object?> get props => [weekly, daily, monthly];
}
