import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/categories/domain/entity/category_entity.dart';
import 'package:cood/features/categories/domain/entity/category_user_entity.dart';
import 'package:cood/features/categories/domain/entity/result_filter_user_by_category_entity.dart';
import 'package:cood/features/categories/domain/entity/social_media_links_entity.dart';

class FilterUserByCategoryRespModel extends BaseOneResponse {
  const FilterUserByCategoryRespModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });
      factory FilterUserByCategoryRespModel.fromJson(Map<String, dynamic> json) => FilterUserByCategoryRespModel(
        status: json["status"],
        data: json["result"] == null ? null : Result.fromJson(json["result"]),
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": data?.toJson(),
        "success": success,
        "message": message,
    };

}
class Result extends ResultEntity{
    

  const  Result({
        super.category,
        super.users,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: json["category"] == null ? null : UserCategory.fromJson(json["category"]),
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}
//----------- user category
class UserCategory extends CategoryEntity {

    const UserCategory({
        super.id,
        super.nameAr,
        super.nameEn,
        super.image,
        super.icon,
    });

    factory UserCategory.fromJson(Map<String, dynamic> json) => UserCategory(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        image: json["image"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "image": image,
        "icon": icon,
    };
}
//------------------user
class User extends CategoryUserEntity{
    const User({
        super.id,
        super.name,
        super.phone,
        super.image,
        super.socialMediaLinks,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        image: json["image"],
        socialMediaLinks: json["social_media_links"] == null ? [] : List<SocialMediaLink>.from(json["social_media_links"]!.map((x) => SocialMediaLink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "image": image,
        "social_media_links": socialMediaLinks == null ? [] : List<dynamic>.from(socialMediaLinks!.map((x) => x.toJson())),
    };
}
//----------------SocialMediaLink
class SocialMediaLink extends SocialMediaLinkEntity {
  const  SocialMediaLink({
        super.id,
        super.platform,
        super.link,
        super.icon,
        super.color,
    });

    factory SocialMediaLink.fromJson(Map<String, dynamic> json) => SocialMediaLink(
        id: json["id"],
        platform: json["platform"],
        link: json["link"],
        icon: json["icon"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "platform": platform,
        "link": link,
        "icon": icon,
        "color": color,
    };
}
