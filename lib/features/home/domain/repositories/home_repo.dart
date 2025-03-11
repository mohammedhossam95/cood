import 'package:dartz/dartz.dart';

import '/core/base_classes/base_list_response.dart';
import '/core/error/failures.dart';
import '/core/params/search_params.dart';

abstract class HomeRepo {
  Future<Either<Failure, BaseListResponse>> getCities(SearchParams params);
}
