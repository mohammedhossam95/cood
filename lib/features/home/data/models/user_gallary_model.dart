import 'package:cood/features/home/domain/entities/user_gallary_entity.dart';

import '/core/base_classes/base_list_response.dart';

class UserGalleryRespModel extends BaseListResponse {
  const UserGalleryRespModel({
    super.message,
    super.status,
    super.data,
  });

  factory UserGalleryRespModel.fromJson(Map<String, dynamic> json) =>
      UserGalleryRespModel(
        message: json["message"],
        status: json["status"],
        data: json["result"] == null
            ? []
            : List<GalleryItemModel>.from(json["result"].map((x) => GalleryItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "result": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GalleryItemModel extends UserGalleryEntity{

  const GalleryItemModel({
    super.id,
    super.userId,
    super.imagePath,
    super.caption,
    super.createdAt,
    super.updatedAt,
    super.imageUrl,
  });

  factory GalleryItemModel.fromJson(Map<String, dynamic> json) {
    return GalleryItemModel(
      id: json["id"],
      userId: json["user_id"],
      imagePath: json["image_path"],
      caption: json["caption"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
      imageUrl: json["image_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "image_path": imagePath,
      "caption": caption,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "image_url": imageUrl,
    };
  }
}
