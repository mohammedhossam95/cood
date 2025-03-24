import 'package:equatable/equatable.dart';

class SendFriendRequestEntity extends Equatable {
  final int? senderId;
  final int? receiverId;
  final String? status;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  const SendFriendRequestEntity({
     this.senderId,
     this.receiverId,
     this.status,
     this.updatedAt,
     this.createdAt,
     this.id,
  });

  @override
  List<Object?> get props => [senderId, receiverId, status, updatedAt, createdAt, id];

}
