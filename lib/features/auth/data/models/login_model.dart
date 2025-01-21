import '../../domain/entities/login_response.dart';

class LoginRespModel extends LoginResponse {
  const LoginRespModel({
    super.value,
    super.key,
    super.msg,
    super.data,
  });

  factory LoginRespModel.fromJson(Map<String, dynamic> json) => LoginRespModel(
        value: json["value"],
        key: json["key"],
        msg: json["msg"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
        "msg": msg,
        "data": (data as UserModel?)?.toJson(),
      };
}

class UserModel extends User {
  const UserModel({
    super.id,
    super.deleted,
    super.name,
    super.email,
    super.phone,
    super.loginConfirmation,
    super.address,
    super.lat,
    super.lng,
    super.code,
    super.avatar,
    super.arrears,
    super.active,
    super.confirm,
    super.role,
    super.notification,
    super.jwtToken,
    super.userType,
    super.commercial,
    super.carNumber,
    super.drivingLicense,
    super.idNumber,
    super.file,
    super.descAr,
    super.descEn,
    super.deliveryPrice,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        deleted: json["deleted"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        loginConfirmation: json["login_confirmation"]?.toString(),
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        code: json["code"],
        avatar: json["avatar"],
        arrears: json["arrears"],
        active: json["active"],
        confirm: json["confirm"],
        role: json["role"],
        notification: json["notification"],
        jwtToken: json["jwt_token"],
        userType: json["user_type"],
        commercial: json["commercial"],
        carNumber: json["car_number"],
        drivingLicense: json["driving_license"],
        idNumber: json["id_number"],
        file: json["file"],
        descAr: json["desc_ar"],
        descEn: json["desc_en"],
        deliveryPrice: json["delivery_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deleted": deleted,
        "name": name,
        "email": email,
        "phone": phone,
        "login_confirmation": loginConfirmation,
        "address": address,
        "lat": lat,
        "lng": lng,
        "code": code,
        "avatar": avatar,
        "arrears": arrears,
        "active": active,
        "confirm": confirm,
        "role": role,
        "notification": notification,
        "jwt_token": jwtToken,
        "user_type": userType,
        "commercial": commercial,
        "car_number": carNumber,
        "driving_license": drivingLicense,
        "id_number": idNumber,
        "file": file,
        "desc_ar": descAr,
        "desc_en": descEn,
        "delivery_price": deliveryPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
