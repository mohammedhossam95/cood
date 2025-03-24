import 'package:equatable/equatable.dart';

class PendingRequestentity extends Equatable {
  final int? requestId;
  final DateTime? createdAt;
  final SenderEntity? sender;

  const PendingRequestentity({
    this.requestId,
    this.createdAt,
    this.sender,
  });

  Map<String, dynamic> toJson() => {
        "request_id": requestId,
        "created_at": createdAt?.toIso8601String(),
        "sender": sender?.toJson(),
      };

  @override
  List<Object?> get props => [requestId, createdAt, sender];
}

class SenderEntity extends Equatable {
  final int? id;
  final String? name;
  final String? code;
  final dynamic image;

  const SenderEntity({
    this.id,
    this.name,
    this.code,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image": image,
      };

  @override
  List<Object?> get props => [id, name, code, image];
}
