import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/reservations/domain/repository/reservation_repository.dart';

import '../../../../core/base_classes/base_list_response.dart';

class GetAdditionalUseCase extends UseCase<BaseListResponse, int> {
  final ReservationRepositry reservationRepositry;

  GetAdditionalUseCase({required this.reservationRepositry});
  @override
  Future<Either<Failure, BaseListResponse>> call(int params) =>
      reservationRepositry.getAdditional(params);
}
