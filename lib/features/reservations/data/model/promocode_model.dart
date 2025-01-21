import '../../domain/entity/promocode.dart';

class PromocodeModel extends Promocode {
  const PromocodeModel({
    super.id,
    super.type,
    super.cars,
    super.name,
    super.percentage,
    super.maxLimit,
    super.topBuyers,
    super.fromDate,
    super.toDate,
    super.createdAt,
  });

  factory PromocodeModel.fromJson(Map<String, dynamic> json) {
    return PromocodeModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      cars: json['cars'],
      percentage: json['percentage'],
      maxLimit: json['max_limit'],
      topBuyers: json['top_buyers'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'cars': cars,
      'percentage': percentage,
      'max_limit': maxLimit,
      'top_buyers': topBuyers,
      'from_date': fromDate,
      'to_date': toDate,
      'createdAt': createdAt,
    };
  }
}
