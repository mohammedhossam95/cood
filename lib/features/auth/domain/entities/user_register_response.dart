import 'package:equatable/equatable.dart';

class RegResult extends Equatable {
  final int? userId;

  const RegResult({
    this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}
