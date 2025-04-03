import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/features/auth/data/models/login_model.dart';
import 'package:cood/features/discover/domain/entities/stories_response.dart';

class StoriesRespModel extends BaseListResponse {
  const StoriesRespModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });

  factory StoriesRespModel.fromJson(Map<String, dynamic> json) =>
      StoriesRespModel(
        status: json["status"],
        data: json["result"] == null
            ? []
            : List<StoryModel>.from(
                json["result"]!.map((x) => StoryModel.fromJson(x))),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "message": message,
      };
}

class StoryModel extends Story {
  const StoryModel({
    super.id,
    super.user,
    super.mediaUrl,
    super.videoThumbnail,
    super.mediaType,
    super.createdAt,
    super.expiresAt,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        id: json["id"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        mediaUrl: json["media_url"],
        videoThumbnail: json["video_thumbnail"],
        mediaType: json["media_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": (user as UserModel?)?.toJson(),
        "media_url": mediaUrl,
        "video_thumbnail": videoThumbnail,
        "media_type": mediaType,
        "created_at": createdAt?.toIso8601String(),
        "expires_at": expiresAt?.toIso8601String(),
      };
}
