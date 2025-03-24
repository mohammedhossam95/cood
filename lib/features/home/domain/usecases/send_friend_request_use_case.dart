// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/repositories/home_repo.dart';

class SendFreindRequestUseCase extends UseCase<BaseOneResponse, int> {
  HomeRepo repository;
  SendFreindRequestUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, BaseOneResponse>> call(int params) async {
    return await repository.sendFriendRequest(params);
  }
}
