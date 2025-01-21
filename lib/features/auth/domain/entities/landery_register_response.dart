import 'package:equatable/equatable.dart';

class LanderyRegisterData extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final String? code;
  final String? userType;
  final String? commercial;
  final String? descAr;
  final String? descEn;
  final String? deliveryPrice;
  final String? deviceId;
  final String? deviceType;
  final String? avatar;
  final DateTime? date;
  final WorkTimes? workTimes;
  final String? token;

  const LanderyRegisterData({
    this.name,
    this.phone,
    this.email,
    this.code,
    this.userType,
    this.commercial,
    this.descAr,
    this.descEn,
    this.deliveryPrice,
    this.deviceId,
    this.deviceType,
    this.avatar,
    this.date,
    this.workTimes,
    this.token,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        code,
        userType,
        commercial,
        descAr,
        descEn,
        deliveryPrice,
        deviceId,
        deviceType,
        avatar,
        date,
        workTimes,
        token,
      ];
}

class WorkTimes extends Equatable {
  final int? id;
  final String? providerId;
  final String? timeFrom;
  final String? timeTo;
  final String? days;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WorkTimes({
    this.id,
    this.providerId,
    this.timeFrom,
    this.timeTo,
    this.days,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        providerId,
        timeFrom,
        timeTo,
        days,
        createdAt,
        updatedAt,
      ];
}
