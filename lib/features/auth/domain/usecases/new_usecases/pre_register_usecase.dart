import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/auth/data/models/new_models/pre_register_model.dart';
import '/features/auth/domain/repositories/auth_repo.dart';

class PreRegisterUsecase
    extends UseCase<PreRegisterResponseModel, PreRegisterParams> {
  final AuthRepository repository;

  PreRegisterUsecase({required this.repository});

  @override
  Future<Either<Failure, PreRegisterResponseModel>> call(
          PreRegisterParams params) async =>
      await repository.preRegisterRepo(params: params);
}

class PreRegisterParams extends Equatable {
  final String? phoneNumber;
  final String? countryCode;

  const PreRegisterParams({
    required this.phoneNumber,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() => {
        'phone_number': phoneNumber,
        'country_code': countryCode,
      };

  @override
  List<Object?> get props => <Object?>[
        phoneNumber,
        countryCode,
      ];
}
