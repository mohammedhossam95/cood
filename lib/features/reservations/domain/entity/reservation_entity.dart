import 'package:equatable/equatable.dart';

import '/features/cars/domain/entities/branch_entity.dart';
import '/features/cars/domain/entities/car_entity.dart';

class GetReservation extends Equatable {
  final int? id;
  final String? fromDate;
  final String? toDate;
  final List<dynamic>? additionals;
  final String? plan;
  final Branch? toBranch;
  final Branch? fromBranch;
  final dynamic promocode;
  final dynamic promocodeName;
  final int? priceWithoutPromocode;
  final CarEntity? car;
  final int? finalPrice;
  final int? additionalsPrice;
  final int? pricePerDay;
  final int? cityFees;
  final int? numberOfDays;
  final dynamic type;
  final String? status;
  final bool? isPaid;
  final bool? isExtend;
  final int? originalReserveId;
  final bool? canExtend;
  final String? createdAt;

  const GetReservation({
    this.id,
    this.fromDate,
    this.toDate,
    this.additionals,
    this.plan,
    this.toBranch,
    this.fromBranch,
    this.promocode,
    this.promocodeName,
    this.priceWithoutPromocode,
    this.car,
    this.finalPrice,
    this.additionalsPrice,
    this.pricePerDay,
    this.cityFees,
    this.numberOfDays,
    this.type,
    this.status,
    this.isPaid,
    this.isExtend,
    this.originalReserveId,
    this.canExtend,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        fromDate,
        toDate,
        additionals,
        toBranch,
        fromBranch,
        promocode,
        promocodeName,
        priceWithoutPromocode,
        car,
        finalPrice,
        additionalsPrice,
        pricePerDay,
        cityFees,
        numberOfDays,
        type,
        status,
        isPaid,
        isExtend,
        originalReserveId,
        canExtend,
        createdAt,
      ];
}
