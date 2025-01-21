// import 'package:equatable/equatable.dart';

// import '../../../profile/domain/entities/get_profile_response.dart';


// class VerifyEmailResponse extends Equatable{
//   final bool success;
//   final String message;
//   final VerifyEmailData data;

//   const VerifyEmailResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   @override
//   List<Object?> get props => <Object?>[
//     success,
//     message,
//     data,
//   ];
// }


// class VerifyEmailData extends Equatable {
//   final String token;
//   final User? user;
//   final String mobile;
//   final SocialUser? socialUser;

//   const VerifyEmailData({
//     required this.token,
//     required this.user,
//     required this.mobile,
//     required this.socialUser,
//   });

//   VerifyEmailData copyWith({
//     String? token,
//     User? user,
//     String? mobile,
//     SocialUser? socialUser,
//   }) {
//     return VerifyEmailData(
//       token: token ?? this.token,
//       user: user ?? this.user,
//       mobile: mobile ?? this.mobile,
//       socialUser: socialUser ?? this.socialUser,
//     );
//   }

//   @override
//   List<Object?> get props => <Object?>[
//     token,
//     user,
//     mobile,
//     socialUser,
//   ];

// }
