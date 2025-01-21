// import 'package:equatable/equatable.dart';
// import 'package:dartz/dartz.dart';

// import '../../../../core/error/failures.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../entities/verify_email_response.dart';
// import '../repositories/auth_repo.dart';


// class VerifyEmailUseCase extends UseCase<VerifyEmailResponse, VerifyEmailParams> {
//   final AuthRepository repository;

//   VerifyEmailUseCase({required this.repository});

//   @override
//   Future<Either<Failure, VerifyEmailResponse>> call(VerifyEmailParams params) async {
//     return await repository.verifyEmail(params: params);
//   }
// }


// class VerifyEmailParams extends Equatable {
//   final String? email;
//   final String? code;

//   const VerifyEmailParams({
//     required this.email,
//     required this.code,
//   });

//   Map<String, dynamic> toJson() => {
//     'email': email,
//     'code': code,
//   };

//   @override
//   List<Object?> get props => <Object?>[
//     email,
//     code,
//   ];

// }



