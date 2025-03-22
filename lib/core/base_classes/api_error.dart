import 'package:equatable/equatable.dart';

class APIError extends Equatable {
  final String? status;
  final bool? success;
  final Map<String, dynamic>? result;
  final String? message;

  const APIError({
    this.status,
    this.success,
    this.result,
    this.message,
  });

  factory APIError.fromJson(Map<String, dynamic> json) {
    return APIError(
      status: json['status'] ?? '',
      success: json['success'] ?? false,
      result: json['result'] ?? {},
      message: json['message'] ?? '',
    );
  }

  /// Get first error from result map, or fallback to message
  String getFirstError() {
    if (result!.isNotEmpty) {
      for (var key in result!.keys) {
        var errors = result![key];
        if (errors is List && errors.isNotEmpty) {
          return '$key: ${errors.first}';
        }
      }
    }
    return message ?? '';
  }

  @override
  List<Object?> get props => [
        status,
        success,
        result,
        message,
      ];
}
