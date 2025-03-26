import 'dart:io';

import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  final String? name;
  final String? phone;
  final String? password;
  final String? passwordConfirm;
  final String? token;
  final String? userType;
  final int? userId;
  final String? otp;
  final File? image;

  const AuthParams({
    this.name,
    this.phone,
    this.password,
    this.passwordConfirm,
    this.token,
    this.userType,
    this.userId,
    this.otp,
    this.image,
  });

  @override
  List<Object?> get props => <Object?>[
        name,
        phone,
        password,
        passwordConfirm,
        token,
        userType,
        userId,
        otp,
        image,
      ];

  Map<String, dynamic> toJson() => {
        'phone': phone,
        "password": password,
        "fcm_device_key": token,
      };
}
