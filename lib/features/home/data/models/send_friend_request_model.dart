import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/home/domain/entities/send_friend_request_entity.dart';

class SendFriendRequestRespModel extends BaseOneResponse{
const  SendFriendRequestRespModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });
  factory SendFriendRequestRespModel.fromJson(Map<String, dynamic> json) =>
      SendFriendRequestRespModel(
        status:json['status'],
        data:json['result']==null?null:SendFreindRequestResult.fromJson(json['result']),
        success: json['success'],
        message: json['message'],

      );
  // Converts model to JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "result": data == null ? null : (data as SendFreindRequestResult).toJson(),
        "success": success,
        "message": message,
      };
}

class SendFreindRequestResult extends SendFriendRequestEntity{
    

  const  SendFreindRequestResult({
        super.senderId,
        super.receiverId,
        super.status,
        super.updatedAt,
        super.createdAt,
        super.id,
    });

    factory SendFreindRequestResult.fromJson(Map<String, dynamic> json) => SendFreindRequestResult(
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        status: json["status"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}