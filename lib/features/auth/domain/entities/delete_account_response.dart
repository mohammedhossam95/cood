import 'package:equatable/equatable.dart';

class DeleteAccountResponse extends Equatable{
  final bool success;
  final String message;

  const DeleteAccountResponse({
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => <Object?>[
    success,
    message,
  ];
}



