import 'package:equatable/equatable.dart';

class DeliveryRegister extends Equatable {
  final String? value;
  final String? key;
  final Data? data;

  const DeliveryRegister({
    this.value,
    this.key,
    this.data,
  });

  factory DeliveryRegister.fromJson(Map<String, dynamic> json) =>
      DeliveryRegister(
        value: json["value"],
        key: json["key"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [
        value,
        key,
        data,
      ];
}

class Data extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final String? code;
  final String? userType;
  final String? commercial;
  final String? descAr;
  final String? descEn;
  final String? deliveryPrice;
  final String? deviceId;
  final String? deviceType;
  final String? avatar;
  final DateTime? date;
  final dynamic workTimes;
  final String? token;

  const Data({
    this.name,
    this.phone,
    this.email,
    this.code,
    this.userType,
    this.commercial,
    this.descAr,
    this.descEn,
    this.deliveryPrice,
    this.deviceId,
    this.deviceType,
    this.avatar,
    this.date,
    this.workTimes,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        code,
        userType,
        commercial,
        descAr,
        descEn,
        deliveryPrice,
        deviceId,
        deviceType,
        avatar,
        date,
        workTimes,
        token,
      ];
}
