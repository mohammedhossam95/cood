import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetPendingRequestUseCase extends UseCase<BaseListResponse, NoParams>{
  final HomeRepo repository; 

  GetPendingRequestUseCase(this.repository);
 @override
  Future<Either<Failure, BaseListResponse>> call(NoParams params) async {
    return await repository.getPendingRequests();
  }
}