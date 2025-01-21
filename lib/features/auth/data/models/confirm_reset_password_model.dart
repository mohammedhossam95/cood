import '../../domain/entities/confirm_reset_password_response.dart';

class ConfirmResetPasswordModel extends ConfirmResetPasswordResponse {
  const ConfirmResetPasswordModel({
    required super.success,
    required super.message,
  });

  factory ConfirmResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ConfirmResetPasswordModel(
        success: json['success'],
        message: json['message'],
      );
}



