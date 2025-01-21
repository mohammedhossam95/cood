import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/login_model.dart';
import '../repositories/auth_repo.dart';

class LoginEmailUseCase extends UseCase<LoginRespModel, LoginParams> {
  final AuthRepository repository;

  LoginEmailUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginRespModel>> call(LoginParams params) async =>
      await repository.loginRepo(params: params);
}

class LoginParams extends Equatable {
  final String? phone;
  final String? userType;

  const LoginParams({
    required this.phone,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'phone': phone,
      };

  @override
  List<Object?> get props => <Object?>[
        phone,
        userType,
      ];
}
