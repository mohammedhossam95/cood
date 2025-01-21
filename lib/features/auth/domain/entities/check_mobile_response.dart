// import 'package:equatable/equatable.dart';

// import '../../../profile/domain/entities/get_profile_response.dart';


// class CheckMobileResponse extends Equatable{
//   final bool success;
//   final String message;
//   final CheckMobileData data;

//   const CheckMobileResponse({
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


// class CheckMobileData extends Equatable {
//   final String token;
//   final User? user;
//   final String mobile;
//   final SocialUser? socialUser;

//   const CheckMobileData({
//     required this.token,
//     required this.user,
//     required this.mobile,
//     required this.socialUser,
//   });

//   CheckMobileData copyWith({
//     String? token,
//     User? user,
//     String? mobile,
//     SocialUser? socialUser,
//   }) {
//     return CheckMobileData(
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
