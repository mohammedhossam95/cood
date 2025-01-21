// import '../../../profile/data/models/get_profile_model.dart';
// import '../../domain/entities/check_mobile_response.dart';

// class CheckMobileModel extends CheckMobileResponse {
//   const CheckMobileModel({
//     required super.success,
//     required super.message,
//     required super.data,
//   });

//   factory CheckMobileModel.fromJson(Map<String, dynamic> json) =>
//       CheckMobileModel(
//         success: json['success'],
//         message: json['message'],
//         data: CheckMobileDataModel.fromJson(json['data']),
//       );
// }

// class CheckMobileDataModel extends CheckMobileData {
//   const CheckMobileDataModel({
//     required super.token,
//     required super.user,
//     required super.mobile,
//     required super.socialUser,
//   });

//   factory CheckMobileDataModel.fromJson(Map<String, dynamic> json) =>
//       CheckMobileDataModel(
//         token: json['token'] ?? '',
//         user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
//         mobile: json['mobile'] ?? '',
//         socialUser: json['social_user'] != null
//             ? SocialUserModel.fromJson(json['social_user'])
//             : null,
//       );
// }
