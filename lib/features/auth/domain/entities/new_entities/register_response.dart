// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  final String? message;
  final int? statusCode;
  final String? time;
  final RegisterDetails? details;

  const RegisterResponse({
    this.message,
    this.statusCode,
    this.time,
    this.details,
  });

  @override
  List<Object?> get props => [
        message,
        statusCode,
        time,
        details,
      ];
}

class RegisterDetails extends Equatable {
  final int? id;
  final String? email;
  final String? username;
  final String? phoneNumber;
  final String? countryCode;
  final String? licencePath;
  final String? identificationPath;
  final String? role;
  final bool? active;
  final String? createdAt;
  final dynamic adminSession;
  final dynamic customerId;
  final bool? admin;
  final bool? verified;
  final bool? banned;

  const RegisterDetails({
    this.id,
    this.email,
    this.username,
    this.phoneNumber,
    this.countryCode,
    this.licencePath,
    this.identificationPath,
    this.role,
    this.active,
    this.createdAt,
    this.adminSession,
    this.customerId,
    this.admin,
    this.verified,
    this.banned,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        phoneNumber,
        countryCode,
        licencePath,
        identificationPath,
        role,
        active,
        createdAt,
        adminSession,
        customerId,
        admin,
        verified,
        banned,
      ];
}
