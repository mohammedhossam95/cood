// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/repositories/home_repo.dart';

class GetSearchUserByCodeUseCase extends UseCase<BaseOneResponse, String> {
  final HomeRepo repository;
  GetSearchUserByCodeUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, BaseOneResponse>> call(String params, ) async{
    return await repository.searchUserByCode(params);
  }
}
