import '../../domain/entities/verify_reset_password_response.dart';

class VerifyResetPasswordModel extends VerifyResetPasswordResponse {
  const VerifyResetPasswordModel({
    required super.success,
    required super.message,
  });

  factory VerifyResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      VerifyResetPasswordModel(
        success: json['success'],
        message: json['message'],
      );
}



