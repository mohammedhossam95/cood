import 'package:equatable/equatable.dart';

class ResetPasswordResponse extends Equatable{
  final bool success;
  final String message;

  const ResetPasswordResponse({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => <Object?>[
    success,
    message,
  ];
}



