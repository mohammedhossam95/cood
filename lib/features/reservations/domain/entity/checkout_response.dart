import 'package:equatable/equatable.dart';

class CheckoutResponse extends Equatable {
  final Result? result;
  final String? buildNumber;
  final String? timestamp;
  final String? ndc;
  final String? id;

  const CheckoutResponse({
    this.result,
    this.buildNumber,
    this.timestamp,
    this.ndc,
    this.id,
  });

  @override
  List<Object?> get props => [
        result,
        buildNumber,
        timestamp,
        ndc,
        id,
      ];
}

class Result extends Equatable {
  final String? code;
  final String? description;

  const Result({
    this.code,
    this.description,
  });

  @override
  List<Object?> get props => [
        code,
        description,
      ];
}
