import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/error/failures.dart';
import 'package:cood/core/params/add_user_account.dart';
import 'package:cood/core/usecases/usecase.dart';
import 'package:cood/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class AddUserSocialAccountUseCase
    extends UseCase<BaseListResponse, AddAccountParams> {
  final HomeRepo repository;

  AddUserSocialAccountUseCase(this.repository);

  @override
  Future<Either<Failure, BaseListResponse>> call(
          AddAccountParams param) async =>
      await repository.addUserSocialAccount(param);
}
