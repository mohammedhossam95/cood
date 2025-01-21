import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/reservations/domain/repository/reservation_repository.dart';

import '../../../../core/base_classes/base_list_response.dart';

class ReservationUseCase extends UseCase<BaseListResponse, NoParams> {
  final ReservationRepositry reservationRepositry;

  ReservationUseCase({required this.reservationRepositry});
  @override
  Future<Either<Failure, BaseListResponse>> call(NoParams params) =>
      reservationRepositry.fetchReservation();
}
