import 'package:equatable/equatable.dart';

class PreRegisterResponse extends Equatable {
  final String? message;
  final int? statusCode;
  final String? time;
  final PreRegisterDetails? details;

  const PreRegisterResponse({
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

class PreRegisterDetails extends Equatable {
  final int? id;
  final dynamic email;
  final dynamic username;
  final String? phoneNumber;
  final String? countryCode;
  final dynamic licencePath;
  final dynamic identificationPath;
  final String? role;
  final bool? active;
  final String? createdAt;
  final dynamic adminSession;
  final dynamic customerId;
  final bool? admin;
  final bool? verified;
  final bool? banned;

  const PreRegisterDetails({
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
