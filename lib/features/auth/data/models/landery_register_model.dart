import '/core/base_classes/base_one_response.dart';
import '../../domain/entities/landery_register_response.dart';

class LanderyRegisterRespModel extends BaseOneResponse {
  const LanderyRegisterRespModel({
    super.value,
    super.key,
    super.data,
  });

  factory LanderyRegisterRespModel.fromJson(Map<String, dynamic> json) =>
      LanderyRegisterRespModel(
        value: json["value"],
        key: json["key"],
        data: json["data"] == null ? null : DataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
        "data": data?.toJson(),
      };
}

class DataModel extends LanderyRegisterData {
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
        workTimes: json["work_times"] == null
            ? null
            : WorkTimesModel.fromJson(json["work_times"]),
        token: json["token"],
      );

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

class WorkTimesModel extends WorkTimes {
  const WorkTimesModel({
    super.id,
    super.providerId,
    super.timeFrom,
    super.timeTo,
    super.days,
    super.createdAt,
    super.updatedAt,
  });

  factory WorkTimesModel.fromJson(Map<String, dynamic> json) => WorkTimesModel(
        id: json["id"],
        providerId: json["provider_id"],
        timeFrom: json["time_from"],
        timeTo: json["time_to"],
        days: json["days"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provider_id": providerId,
        "time_from": timeFrom,
        "time_to": timeTo,
        "days": days,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
