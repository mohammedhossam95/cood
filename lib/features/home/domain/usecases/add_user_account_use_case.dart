import 'package:cood/core/base_classes/base_list_response.dart';
import 'package:cood/core/google_search/core/error/failures/i_failure.dart';
import 'package:cood/core/params/add_user_account.dart';
import 'package:cood/features/home/domain/repositories/home_repo.dart';
import 'package:cood/core/google_search/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class AddUserSocialAccountUseCase
    extends UseCase<BaseListResponse, AddAccountParams> {
  final HomeRepo repository;

  AddUserSocialAccountUseCase(this.repository);

  @override
  Future<Either<Failure, BaseListResponse>> call(
      {required AddAccountParams param}) async {
    return await repository.addUserSocialAccount(param);
  }
}
