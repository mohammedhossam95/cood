import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/verify_reset_password_response.dart';
import '../repositories/auth_repo.dart';


class VerifyResetPasswordUseCase extends UseCase<VerifyResetPasswordResponse, VerifyResetPasswordParams> {
  final AuthRepository repository;

  VerifyResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, VerifyResetPasswordResponse>> call(VerifyResetPasswordParams params) async {
    return await repository.verifyResetPassword(params: params);
  }
}


class VerifyResetPasswordParams extends Equatable {
  final String? email;
  final String? code;

  const VerifyResetPasswordParams({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'code': code,
  };

  @override
  List<Object?> get props => <Object?>[
    email,
    code,
  ];

}



