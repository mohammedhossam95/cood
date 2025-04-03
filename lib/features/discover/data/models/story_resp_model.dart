import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/features/discover/data/models/stories_resp_model.dart';

class StoryRespModel extends BaseOneResponse {
  const StoryRespModel({
    super.status,
    super.data,
    super.success,
    super.message,
  });

  factory StoryRespModel.fromJson(Map<String, dynamic> json) => StoryRespModel(
        status: json["status"],
        data:
            json["result"] == null ? null : StoryModel.fromJson(json["result"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": (data as StoryModel?)?.toJson(),
        "success": success,
        "message": message,
      };
}
