import 'package:equatable/equatable.dart';

class LogoutResponse extends Equatable{
  final bool success;
  final String message;

  const LogoutResponse({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => <Object?>[
    success,
    message,
  ];
}



