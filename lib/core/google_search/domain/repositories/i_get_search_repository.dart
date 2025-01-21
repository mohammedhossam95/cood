import 'package:dartz/dartz.dart';

import '../../core/error/failures/i_failure.dart';
import '../../domain/entities/lat_lng_entity.dart';
import '../../domain/entities/param_search_entity.dart';
import '../entities/awesome_place_entity.dart';

abstract class IGetSearchRepository {
  Future<Either<Failure, LatLngEntity>> getLatLng({required String placeId});
  Future<Either<Failure, AwesomePlacesSearchEntity>> getPlace(
      {required ParamSearchEntity param});
}
