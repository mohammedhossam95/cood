import 'package:dartz/dartz.dart';

import '../../core/error/failures/i_failure.dart';
import '../../domain/entities/awesome_place_entity.dart';
import '../../domain/entities/lat_lng_entity.dart';
import '../../domain/entities/param_search_entity.dart';
import '../../domain/repositories/i_get_search_repository.dart';

part 'get_lat_lng_usecase.dart';
part 'get_places_usecase.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call({required Param param});
}
