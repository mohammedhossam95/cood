import 'package:equatable/equatable.dart';

class AdditionalEntity extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? descEn;
  final String? descAr;
  final num? price;
  final num? minReserveDays;
  final String? termsEn;
  final String? termsAr;
  final int? categoryId;
  final bool? deleted;
  final int? customerId;
  final bool? allPrice;

  const AdditionalEntity({
    this.id,
    this.nameEn,
    this.nameAr,
    this.descEn,
    this.descAr,
    this.price,
    this.minReserveDays,
    this.termsEn,
    this.termsAr,
    this.categoryId,
    this.deleted,
    this.customerId,
    this.allPrice,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        descEn,
        descAr,
        price,
        minReserveDays,
        termsEn,
        termsAr,
        categoryId,
        deleted,
        customerId,
        allPrice,
      ];
}
