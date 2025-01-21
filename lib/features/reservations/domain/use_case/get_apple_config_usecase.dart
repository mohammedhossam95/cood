import 'package:dartz/dartz.dart';

import '/core/params/car_params.dart';
import '/features/reservations/domain/entity/checkout_response.dart';
import '/features/reservations/domain/repository/reservation_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetAppleConfigUseCase extends UseCase<CheckoutResponse, CarParams> {
  final ReservationRepositry reservationRepositry;

  GetAppleConfigUseCase({required this.reservationRepositry});

  @override
  Future<Either<Failure, CheckoutResponse>> call(CarParams params) =>
      reservationRepositry.getConfig(params);
}
