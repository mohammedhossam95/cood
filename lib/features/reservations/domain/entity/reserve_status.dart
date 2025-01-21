import 'package:equatable/equatable.dart';

import '/features/cars/domain/entities/branch_entity.dart';
import '/features/cars/domain/entities/car_entity.dart';
import '/features/reservations/data/model/additional_model.dart';
import '/features/reservations/domain/entity/promocode.dart';

class ReserveDetails extends Equatable {
  final int? id;
  final String? fromDate;
  final String? toDate;
  final List<AdditionalDetail>? additionals;
  final Branch? toBranch;
  final Branch? fromBranch;
  final Promocode? promocode;
  final String? promocodeName;
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
  final String? paymentCode;
  final bool? canExtend;
  final String? createdAt;
  final String? plan;

  const ReserveDetails({
    this.id,
    this.fromDate,
    this.toDate,
    this.additionals,
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
    this.paymentCode,
    this.canExtend,
    this.createdAt,
    this.plan,
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
        paymentCode,
        canExtend,
        createdAt,
        plan,
      ];
}
