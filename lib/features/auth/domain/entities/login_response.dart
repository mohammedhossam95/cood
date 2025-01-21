import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String? value;
  final String? key;
  final String? msg;
  final User? data;

  const LoginResponse({
    this.value,
    this.key,
    this.msg,
    this.data,
  });

  @override
  List<Object?> get props => [
        value,
        key,
        msg,
        data,
      ];
}

class User extends Equatable {
  final int? id;
  final String? deleted;
  final String? name;
  final dynamic email;
  final String? phone;
  final String? loginConfirmation;
  final String? address;
  final String? lat;
  final String? lng;
  final String? code;
  final String? avatar;
  final String? arrears;
  final String? active;
  final String? confirm;
  final String? role;
  final String? notification;
  final String? jwtToken;
  final String? userType;
  final dynamic commercial;
  final dynamic carNumber;
  final dynamic drivingLicense;
  final dynamic idNumber;
  final dynamic file;
  final dynamic descAr;
  final dynamic descEn;
  final String? deliveryPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    this.deleted,
    this.name,
    this.email,
    this.phone,
    this.loginConfirmation,
    this.address,
    this.lat,
    this.lng,
    this.code,
    this.avatar,
    this.arrears,
    this.active,
    this.confirm,
    this.role,
    this.notification,
    this.jwtToken,
    this.userType,
    this.commercial,
    this.carNumber,
    this.drivingLicense,
    this.idNumber,
    this.file,
    this.descAr,
    this.descEn,
    this.deliveryPrice,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        deleted,
        name,
        email,
        phone,
        loginConfirmation,
        address,
        lat,
        lng,
        code,
        avatar,
        arrears,
        active,
        confirm,
        role,
        notification,
        jwtToken,
        userType,
        commercial,
        carNumber,
        drivingLicense,
        idNumber,
        file,
        descAr,
        descEn,
        deliveryPrice,
        createdAt,
        updatedAt,
      ];
}
