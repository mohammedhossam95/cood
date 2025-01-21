import '/core/base_classes/base_list_response.dart';
import '/features/cars/data/models/branches_resp_model.dart';

class BranchRespModel extends BaseListResponse {
  const BranchRespModel({
    super.data,
    super.message,
    super.statusCode,
  });

  factory BranchRespModel.fromJson(Map<String, dynamic>? json) {
    return BranchRespModel(
      message: json == null ? '' : json['message'],
      data: json == null
          ? []
          : (json['details'] as List?)
              ?.map((car) => BranchModel.fromJson(car))
              .toList(),
    );
  }
}
