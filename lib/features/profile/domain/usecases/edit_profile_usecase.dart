import 'package:cood/core/base_classes/base_one_response.dart';
import 'package:cood/core/params/auth_params.dart';
import 'package:cood/features/profile/domain/repositories/profile_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class EditProfileUseCase implements UseCase<BaseOneResponse, AuthParams> {
  final ProfileRepo profileRepo;

  EditProfileUseCase({required this.profileRepo});
  @override
  Future<Either<Failure, BaseOneResponse>> call(AuthParams params) =>
      profileRepo.editUser(params);
}
