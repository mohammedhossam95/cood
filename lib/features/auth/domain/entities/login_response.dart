import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String? status;
  final LoginResult? result;
  final bool? success;
  final String? message;

  const LoginResponse({
    this.status,
    this.result,
    this.success,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        result,
        success,
        message,
      ];
}

class LoginResult extends Equatable {
  final User? user;
  final String? token;

  const LoginResult({
    this.user,
    this.token,
  });

  @override
  List<Object?> get props => [
        user,
        token,
      ];
}

class User extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? fcmDeviceKey;
  final String? code;

  const User({
    this.id,
    this.name,
    this.phone,
    this.fcmDeviceKey,
    this.code,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        fcmDeviceKey,
        code,
      ];
}
