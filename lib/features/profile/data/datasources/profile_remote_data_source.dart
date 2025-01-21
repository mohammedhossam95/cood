import '/core/error/exceptions.dart';
import '/features/profile/data/models/user_res_model.dart';
import '/injection_container.dart';

abstract class ProfileRemoteDataSource {
  Future<UserRespModel> getUser();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<UserRespModel> getUser() async {
    try {
      final response = await dioConsumer.get(
        'https://jzl-sa.net/api/v1/users/current_user',
      );
      if (response['status_code'] == 200) {
        return UserRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } catch (e) {
      rethrow;
    }
  }
}
