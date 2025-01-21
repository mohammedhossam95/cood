import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/verify_otp_model.dart';
import '../repositories/auth_repo.dart';

class VerifyOtpUseCase
    extends UseCase<ConfirmCodeAuthRespModel, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, ConfirmCodeAuthRespModel>> call(
      VerifyOtpParams params) async {
    return await repository.verifyOtpRpo(params: params);
  }
}

class VerifyOtpParams extends Equatable {
  final String? phone;
  final String? code;
  final String? deviceId;
  final String? deviceType;

  const VerifyOtpParams({
    this.phone,
    this.code,
    this.deviceId,
    this.deviceType,
  });

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "login_confirmation": code,
        "device_id": deviceId,
        "device_type": deviceType,
      };

  @override
  List<Object?> get props => <Object?>[
        phone,
        code,
        deviceId,
        deviceType,
      ];
}
