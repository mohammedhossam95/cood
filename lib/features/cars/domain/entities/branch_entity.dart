import 'package:equatable/equatable.dart';

import '/features/cars/domain/entities/car_entity.dart';

class Branch extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final int? cityId;
  final City? city;
  final double? longitude;
  final double? latitude;
  final String? phoneNumber;
  final String? phoneNumberTwo;
  final String? email;
  final int? rowOrder;
  final bool? deleted;
  final int? customerId;

  const Branch({
    this.id,
    this.nameEn,
    this.nameAr,
    this.cityId,
    this.city,
    this.longitude,
    this.latitude,
    this.phoneNumber,
    this.phoneNumberTwo,
    this.email,
    this.rowOrder,
    this.deleted,
    this.customerId,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        cityId,
        city,
        longitude,
        latitude,
        phoneNumber,
        phoneNumberTwo,
        email,
        rowOrder,
        deleted,
        customerId,
      ];
}
