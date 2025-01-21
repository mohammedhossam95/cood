import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
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
  final String? adminSession;
  final String? customerId;
  final bool? isAdmin;
  final bool? isVerified;
  final bool? isBanned;

  const UserDetailsEntity({
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
    this.isAdmin,
    this.isVerified,
    this.isBanned,
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
        isAdmin,
        isVerified,
        isBanned,
      ];
}
