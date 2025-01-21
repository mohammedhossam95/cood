import '../../data/models/awesome_place_model.dart';
import '../../data/models/lat_lng_model.dart';

abstract class IGetSearchRemoteDataSource {
  Future<LatLngModel> getLatLng({required String param});

  Future<AwesomePlacesSearchModel> getPlace({required ParamSearchModel param});
}
