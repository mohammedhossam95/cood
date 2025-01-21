import 'package:equatable/equatable.dart';

class ConfirmResetPasswordResponse extends Equatable{
  final bool success;
  final String message;

  const ConfirmResetPasswordResponse({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => <Object?>[
    success,
    message,
  ];
}



