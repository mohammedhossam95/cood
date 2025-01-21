// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String? message;
  final int? statusCode;
  final String? time;
  final LoginDetails? details;

  const LoginResponse({
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

class LoginDetails extends Equatable {
  final String? token;
  final int? id;
  final String? loginKey;
  final dynamic session;
  final String? username;
  final String? role;
  final String? status;

  const LoginDetails({
    this.token,
    this.id,
    this.loginKey,
    this.session,
    this.username,
    this.role,
    this.status,
  });

  @override
  List<Object?> get props => [
        token,
        id,
        loginKey,
        session,
        username,
        role,
        status,
      ];
}
