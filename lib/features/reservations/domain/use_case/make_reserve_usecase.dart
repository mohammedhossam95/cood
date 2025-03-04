import 'package:dartz/dartz.dart';

import '/core/base_classes/base_one_response.dart';
import '/core/params/car_params.dart';
import '/features/reservations/domain/repository/reservation_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class MakeReserveUseCase extends UseCase<BaseOneResponse, CarParams> {
  final ReservationRepositry reservationRepositry;

  MakeReserveUseCase({required this.reservationRepositry});

  @override
  Future<Either<Failure, BaseOneResponse>> call(CarParams params) =>
      reservationRepositry.reserve(params);
}
