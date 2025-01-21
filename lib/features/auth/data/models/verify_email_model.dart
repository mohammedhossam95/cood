// import '../../../profile/data/models/get_profile_model.dart';
// import '../../domain/entities/verify_email_response.dart';

// class VerifyEmailModel extends VerifyEmailResponse {
//   const VerifyEmailModel({
//     required super.success,
//     required super.message,
//     required super.data,
//   });

//   factory VerifyEmailModel.fromJson(Map<String, dynamic> json) =>
//       VerifyEmailModel(
//         success: json['success'],
//         message: json['message'],
//         data: VerifyEmailDataModel.fromJson(json['data']),
//       );
// }


// class VerifyEmailDataModel extends VerifyEmailData {
//   const VerifyEmailDataModel({
//     required super.token,
//     required super.user,
//     required super.mobile,
//     required super.socialUser,
//   });

//   factory VerifyEmailDataModel.fromJson(Map<String, dynamic> json) => VerifyEmailDataModel(
//     token: json['token'] ?? '',
//     user: json['user'] != null? UserModel.fromJson(json['user']) : null,
//     mobile: json['mobile'] ?? '',
//     socialUser: json['social_user'] != null? SocialUserModel.fromJson(json['social_user']) : null,
//   );

// }

