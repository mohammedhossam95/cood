import 'package:equatable/equatable.dart';

class PriceStatus extends Equatable {
  final dynamic reserveId;
  final int? paidPointsReyalConverted;
  final int? finalPrice;
  final bool? pointsCoverPrice;

  const PriceStatus({
    this.reserveId,
    this.paidPointsReyalConverted,
    this.finalPrice,
    this.pointsCoverPrice,
  });

  @override
  List<Object?> get props => [
        reserveId,
        paidPointsReyalConverted,
        finalPrice,
        pointsCoverPrice,
      ];
}
