import 'package:equatable/equatable.dart';

class VerifyResetPasswordResponse extends Equatable{
  final bool success;
  final String message;

  const VerifyResetPasswordResponse({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => <Object?>[
    success,
    message,
  ];
}



