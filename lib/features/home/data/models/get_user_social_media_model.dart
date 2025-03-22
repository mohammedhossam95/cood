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
        : List<UserSocialMediaItemModel>.from(json["result"].map((x) => UserSocialMediaItemModel.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "result": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
class UserSocialMediaItemModel extends SocialMediaEntity {
  const UserSocialMediaItemModel({
    super.id,
    super.platform,
    super.icon,
    super.link,
    super.color,
    super.inputType,
  });

  factory UserSocialMediaItemModel.fromJson(Map<String, dynamic> json) => UserSocialMediaItemModel(
        id: json["id"],
        platform: json["platform"],
        icon: json["icon"],
        link: json["link"],
        color: json["color"],
        inputType: json["input_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "platform": platform,
        "icon": icon,
        "link": link,
        "color":color,
        "input_type":inputType,


      };
}