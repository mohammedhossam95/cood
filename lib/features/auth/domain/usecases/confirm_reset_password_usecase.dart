import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/confirm_reset_password_response.dart';
import '../repositories/auth_repo.dart';


class ConfirmResetPasswordUseCase extends UseCase<ConfirmResetPasswordResponse, ConfirmResetPasswordParams> {
  final AuthRepository repository;

  ConfirmResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, ConfirmResetPasswordResponse>> call(ConfirmResetPasswordParams params) async {
    return await repository.confirmResetPassword(params: params);
  }
}


class ConfirmResetPasswordParams extends Equatable {
  final String? email;
  final String? password;
  final String? passwordConfirmation;

  const ConfirmResetPasswordParams({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation,
  };

  @override
  List<Object?> get props => <Object?>[
    email,
    password,
    passwordConfirmation,
  ];

}



