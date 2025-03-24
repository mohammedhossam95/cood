import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/home/domain/entities/search_user_by_code_entity.dart';

class SearchUserByCodeRespModel extends BaseOneResponse {
  const SearchUserByCodeRespModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });
  factory SearchUserByCodeRespModel.fromJson(Map<String, dynamic> json) =>
      SearchUserByCodeRespModel(
        status:json['status'],
        data:json['result']==null?null:UserByCodeModel.fromJson(json['result']),
        success: json['success'],
        message: json['message'],

      );
  // Converts model to JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "result": data == null ? null : (data as UserByCodeModel).toJson(),
        "success": success,
        "message": message,
      };
}

class UserByCodeModel extends SearchUserByCodeEntity {
  const UserByCodeModel({
    super.id,
    super.name,
    super.code,
    super.image,
    super.friendshipStatus,
  });
  factory UserByCodeModel.fromJson(Map<String, dynamic> json) {
    return UserByCodeModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      image: json['image'],
      friendshipStatus: json['friendship_status'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image": image,
        "friendship_status": friendshipStatus,
      };
}
