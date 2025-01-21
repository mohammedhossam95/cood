import 'package:dartz/dartz.dart';
import '/core/base_classes/base_one_response.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/reservations/domain/repository/reservation_repository.dart';

class GetPlansUseCase extends UseCase<BaseOneResponse, NoParams> {
  final ReservationRepositry reservationRepositry;

  GetPlansUseCase({required this.reservationRepositry});
  @override
  Future<Either<Failure, BaseOneResponse>> call(NoParams params) =>
      reservationRepositry.getPlans();
}
