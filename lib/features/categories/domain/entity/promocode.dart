import 'package:equatable/equatable.dart';

class Promocode extends Equatable {
  final int? id;
  final String? type;
  final List<dynamic>? cars;
  final String? name;
  final int? percentage;
  final int? maxLimit;
  final int? topBuyers;
  final String? fromDate;
  final String? toDate;
  final String? createdAt;

  const Promocode({
    this.cars,
    this.name,
    this.percentage,
    this.maxLimit,
    this.topBuyers,
    this.id,
    this.fromDate,
    this.toDate,
    this.type,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        cars,
        name,
        percentage,
        maxLimit,
        topBuyers,
        fromDate,
        toDate,
        createdAt,
      ];
}
