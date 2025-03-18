import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/features/home/domain/entities/all_social_media_entity.dart';



 class AllSocialMediaRespModel extends BaseListResponse{
  const AllSocialMediaRespModel({
    super.message,
    super.status,
    super.data,
  });
  factory AllSocialMediaRespModel.fromJson(Map<String, dynamic> json) => AllSocialMediaRespModel(
    message: json["message"],
    status: json["status"],
    data: json["result"] == null
        ? []
        : List<AllSocialMediaItemModel>.from(json["result"].map((x) => AllSocialMediaItemModel.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "result": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
class AllSocialMediaItemModel extends AllSocialMediaEntity {
  const AllSocialMediaItemModel({
    super.id,
    super.name,
    super.icon,
    super.color,
    
  });

  factory AllSocialMediaItemModel.fromJson(Map<String, dynamic> json) => AllSocialMediaItemModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "color": color,
      };
}