import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/features/home/domain/entities/pending_request_entity.dart';

class PendingRequestsRespModel extends BaseListResponse{
  const PendingRequestsRespModel({
    super.status,
    super.data,
    super.message,
  });
  factory PendingRequestsRespModel.fromJson(Map<String, dynamic> json) => PendingRequestsRespModel(
    
    message: json["message"],
    status: json["status"],
    data: json["result"] == null
        ? []
        : List<PendRequestItem>.from(json["result"].map((x) => PendRequestItem.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "result": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
class PendRequestItem extends PendingRequestentity{
  const  PendRequestItem({
        super.requestId,
        super.createdAt,
        super.sender,
    });

    factory PendRequestItem.fromJson(Map<String, dynamic> json) => PendRequestItem(
        requestId: json["request_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    );

    @override
      Map<String, dynamic> toJson() => {
        "request_id": requestId,
        "created_at": createdAt?.toIso8601String(),
        "sender": sender?.toJson(),
    };
}
class Sender extends SenderEntity{


  const  Sender({
        super.id,
        super.name,
        super.code,
        super.image,
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        image: json["image"],
    );

    
      @override
        Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image": image,
    };
}