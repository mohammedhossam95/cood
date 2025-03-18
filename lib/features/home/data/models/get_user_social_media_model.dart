import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/features/home/domain/entities/user_social_media_entity.dart';



 class SocialMediaRespModel extends BaseListResponse{
  const SocialMediaRespModel({
    super.message,
    super.status,
    super.data,
  });
  factory SocialMediaRespModel.fromJson(Map<String, dynamic> json) => SocialMediaRespModel(
    message: json["message"],
    status: json["status"],
    data: json["result"] == null
        ? []
        : List<SocialMediaItemModel>.from(json["result"].map((x) => SocialMediaItemModel.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "result": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
class SocialMediaItemModel extends SocialMediaEntity {
  const SocialMediaItemModel({
    super.id,
    super.platform,
    super.icon,
    super.link,
  });

  factory SocialMediaItemModel.fromJson(Map<String, dynamic> json) => SocialMediaItemModel(
        id: json["id"],
        platform: json["platform"],
        icon: json["icon"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "platform": platform,
        "icon": icon,
        "link": link,
      };
}