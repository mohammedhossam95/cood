import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/auth/data/models/new_models/login_model.dart';
import '/features/auth/domain/repositories/auth_repo.dart';

class NewLoginUsecase extends UseCase<LoginResponseModel, NewLoginParams> {
  final AuthRepository repository;

  NewLoginUsecase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call(
          NewLoginParams params) async =>
      await repository.newLoginRepo(params: params);
}

class NewLoginParams extends Equatable {
  final String? phoneNumber;
  final String? password;
  final String? fcmToken;

  const NewLoginParams({
    required this.phoneNumber,
    required this.password,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() => {
        'phone_number': phoneNumber,
        'password': password,
        'fcm_token': fcmToken,
      };

  @override
  List<Object?> get props => <Object?>[
        phoneNumber,
        password,
        fcmToken,
      ];
}
