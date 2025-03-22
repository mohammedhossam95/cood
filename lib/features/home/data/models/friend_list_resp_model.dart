import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/features/home/domain/entities/friend_entity_.dart';

class FriendshipInfoModel extends FriendshipInfoEntity {
  const FriendshipInfoModel({
    super.id,
    super.createdAt,
    super.isSender,
  });

  factory FriendshipInfoModel.fromJson(Map<String, dynamic> json) =>
      FriendshipInfoModel(
        id: json["id"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        isSender: json["isSender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "isSender": isSender,
      };
}

class FriendListRespModel extends BaseListResponse {
  const FriendListRespModel({
    super.message,
    super.status,
    super.data,
  });

  factory FriendListRespModel.fromJson(Map<String, dynamic> json) =>
      FriendListRespModel(
        message: json["message"],
        status: json["status"],
        data: json["result"] == null
            ? []
            : List<FriendItemModel>.from(
                json["result"].map((x) => FriendItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "result": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FriendItemModel extends FriendEntity {
  const FriendItemModel({
    super.id,
    super.name,
    super.phone,
    super.code,
    super.image,
    super.friendshipId,
    super.socialMediaLinks,
    super.friendshipInfo,
  });

  factory FriendItemModel.fromJson(Map<String, dynamic> json) =>
      FriendItemModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        code: json["code"],
        image: json["image"],
        friendshipId: json["friendshipId"],
        socialMediaLinks: json["socialMediaLinks"] == null
            ? null
            : List<String>.from(json["socialMediaLinks"]),
        friendshipInfo: json["friendshipInfo"] == null
            ? null
            : FriendshipInfoModel.fromJson(json["friendshipInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "code": code,
        "image": image,
        "friendshipId": friendshipId,
        "socialMediaLinks": socialMediaLinks == null
            ? null
            : List<dynamic>.from(socialMediaLinks!),
        "friendshipInfo": friendshipInfo == null
            ? null
            : (friendshipInfo as FriendshipInfoModel).toJson(),
      };
}
