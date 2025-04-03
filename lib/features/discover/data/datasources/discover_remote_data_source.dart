import 'package:cood/core/error/exceptions.dart';
import 'package:cood/features/discover/data/models/stories_resp_model.dart';
import 'package:cood/features/discover/data/models/story_resp_model.dart';
import 'package:cood/features/discover/presentation/screens/story_preview_screen.dart';
import 'package:cood/injection_container.dart';
import 'package:dio/dio.dart';

abstract class DiscoverRemoteDataSource {
  Future<StoriesRespModel> getRemoteStories();
  Future<StoryRespModel> addRemoteStory(PreviewParams params);
}

class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  @override
  Future<StoriesRespModel> getRemoteStories() async {
    try {
      final response = await dioConsumer.get(
        '/stories/friends',
      );
      if (response['status'] == 'success' && response['result'] != null) {
        return StoriesRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<StoryRespModel> addRemoteStory(PreviewParams params) async {
    try {
      FormData formData = FormData();
      formData.files.add(
        MapEntry(
          "media",
          await MultipartFile.fromFile(
            params.mediaFile.path,
            filename: params.mediaFile.path.split('/').last,
          ),
        ),
      );
      final response = await dioConsumer.post(
        '/stories/add',
        formData: formData,
      );
      if (response['status'] == 'success' && response['result'] != null) {
        return StoryRespModel.fromJson(response);
      }
      throw ServerException(message: response['message'] ?? '');
    } on ServerException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
