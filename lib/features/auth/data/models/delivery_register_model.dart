import '../../domain/entities/delivery_register_response.dart';

class DeliveryRegisterRespModel extends DeliveryRegister {
  const DeliveryRegisterRespModel({
    super.value,
    super.key,
    super.data,
  });

  factory DeliveryRegisterRespModel.fromJson(Map<String, dynamic> json) =>
      DeliveryRegisterRespModel(
        value: json["value"],
        key: json["key"],
        data: json["data"] == null ? null : DataModel.fromJson(json["data"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
        "data": data?.toJson(),
      };
}

class DataModel extends Data {
  const DataModel({
    super.name,
    super.phone,
    super.email,
    super.code,
    super.userType,
    super.commercial,
    super.descAr,
    super.descEn,
    super.deliveryPrice,
    super.deviceId,
    super.deviceType,
    super.avatar,
    super.date,
    super.workTimes,
    super.token,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        code: json["code"],
        userType: json["user_type"],
        commercial: json["commercial"],
        descAr: json["desc_ar"],
        descEn: json["desc_en"],
        deliveryPrice: json["delivery_price"],
        deviceId: json["device_id"],
        deviceType: json["device_type"],
        avatar: json["avatar"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        workTimes: json["work_times"],
        token: json["token"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "code": code,
        "user_type": userType,
        "commercial": commercial,
        "desc_ar": descAr,
        "desc_en": descEn,
        "delivery_price": deliveryPrice,
        "device_id": deviceId,
        "device_type": deviceType,
        "avatar": avatar,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "work_times": workTimes,
        "token": token,
      };
}
