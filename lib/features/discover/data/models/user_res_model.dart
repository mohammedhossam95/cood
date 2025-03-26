import '/core/base_classes/base_one_response.dart';
import '/features/profile/domain/entities/user_entity.dart';

class UserRespModel extends BaseOneResponse {
  const UserRespModel({
    super.data,
    super.statusCode,
    super.message,
  });

  factory UserRespModel.fromJson(json) {
    return UserRespModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: UserDetailsModel.fromJson(json["details"]));
  }
}

class UserDetailsModel extends UserDetailsEntity {
  const UserDetailsModel({
    super.id,
    super.email,
    super.username,
    super.phoneNumber,
    super.countryCode,
    super.licencePath,
    super.identificationPath,
    super.role,
    super.active,
    super.createdAt,
    super.adminSession,
    super.customerId,
    super.isAdmin,
    super.isVerified,
    super.isBanned,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      phoneNumber: json['phone_number'],
      countryCode: json['country_code'],
      licencePath: json['licence_path'],
      identificationPath: json['identification_path'],
      role: json['role'],
      active: json['active'],
      createdAt: json['created_at'],
      adminSession: json['admin_session'],
      customerId: json['customer_id'],
      isAdmin: json['_admin'],
      isVerified: json['_verified'],
      isBanned: json['_banned'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'licence_path': licencePath,
      'identification_path': identificationPath,
      'role': role,
      'active': active,
      'created_at': createdAt,
      'admin_session': adminSession,
      'customer_id': customerId,
      '_admin': isAdmin,
      '_verified': isVerified,
      '_banned': isBanned,
    };
  }

  UserDetailsEntity toEntity() {
    return UserDetailsEntity(
      id: id,
      email: email,
      username: username,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      licencePath: licencePath,
      identificationPath: identificationPath,
      role: role,
      active: active,
      createdAt: createdAt,
      adminSession: adminSession,
      customerId: customerId,
      isAdmin: isAdmin,
      isVerified: isVerified,
      isBanned: isBanned,
    );
  }
}
