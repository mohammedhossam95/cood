import 'package:cood/core/params/auth_params.dart';
import 'package:cood/features/profile/data/models/edit_user_resp_model.dart';
import 'package:dio/dio.dart';

import '/core/error/exceptions.dart';
import '/injection_container.dart';

abstract class ProfileRemoteDataSource {
  Future<EditUserRespModel> editRemoteUser(AuthParams params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<EditUserRespModel> editRemoteUser(AuthParams params) async {
    try {
      var formData = FormData();
      formData.fields.add(MapEntry('name', params.name.toString()));

      if (params.image != null) {
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              params.image!.path,
              filename: params.image!.path.split('/').last,
            ),
          ),
        );
      }

      final response = await dioConsumer.post(
        '/profile',
        formData: formData,
      );
      if (response['success'] == true) {
        return EditUserRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (e) {
      rethrow;
    }
  }
}
