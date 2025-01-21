import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reset_password_response.dart';
import '../repositories/auth_repo.dart';


class ResetPasswordUseCase extends UseCase<ResetPasswordResponse, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, ResetPasswordResponse>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(params: params);
  }
}


class ResetPasswordParams extends Equatable {
  final String? email;

  const ResetPasswordParams({
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
  };

  @override
  List<Object?> get props => <Object?>[
    email,
  ];

}



