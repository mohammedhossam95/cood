// import 'package:equatable/equatable.dart';
// import 'package:dartz/dartz.dart';

// import '../../../../core/error/failures.dart';
// import '../../../../core/usecases/usecase.dart';
// import '../entities/check_mobile_response.dart';
// import '../repositories/auth_repo.dart';


// class CheckMobileUseCase extends UseCase<CheckMobileResponse, CheckMobileParams> {
//   final AuthRepository repository;

//   CheckMobileUseCase({required this.repository});

//   @override
//   Future<Either<Failure, CheckMobileResponse>> call(CheckMobileParams params) async {
//     return await repository.checkMobile(params: params);
//   }
// }


// class CheckMobileParams extends Equatable {
//   final String? mobile;
//   final String? callingCode;

//   const CheckMobileParams({
//     required this.mobile,
//     required this.callingCode,
//   });

//   Map<String, dynamic> toJson() => {
//     'mobile': mobile,
//     'calling_code': callingCode,
//   };

//   @override
//   List<Object?> get props => <Object?>[
//     mobile,
//     callingCode,
//   ];

// }



