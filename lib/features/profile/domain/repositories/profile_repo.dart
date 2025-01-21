import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';

abstract class ProfileRepo {
  Future<Either<Failure, BaseOneResponse>> getUser();
}
