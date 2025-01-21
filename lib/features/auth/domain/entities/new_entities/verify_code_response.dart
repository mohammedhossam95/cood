// To parse this JSON data, do
//
//     final verifyCodeResponse = verifyCodeResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class VerifyCodeResponse extends Equatable {
  final String? message;
  final int? statusCode;
  final String? time;
  final String? details;

  const VerifyCodeResponse({
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
