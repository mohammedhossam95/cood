import '/core/base_classes/base_list_response.dart';
import '/features/cars/domain/entities/car_entity.dart';
import '/features/home/data/models/city_resp_model.dart';

class AvailableCarsRespModel extends BaseListResponse {
  const AvailableCarsRespModel({
    super.data,
    super.message,
    super.statusCode,
  });

  factory AvailableCarsRespModel.fromJson(Map<String, dynamic>? json) {
    return AvailableCarsRespModel(
      message: json == null ? '' : json['message'],
      data: json == null
          ? []
          : (json['details'] as List?)
              ?.map((car) => CarModel.fromJson(car))
              .toList(),
    );
  }
}

class CarModel extends CarEntity {
  const CarModel({
    super.id,
    super.carImagesId,
    super.carImages,
    super.cities,
    super.brandNameEn,
    super.brandNameAr,
    super.modelNameEn,
    super.modelNameAr,
    super.year,
    super.price,
    super.weeklyPrice,
    super.oneMonthPrice,
    super.threeMonthPrice,
    super.sixMonthPrice,
    super.nineMonthPrice,
    super.saveThreeMonth,
    super.saveSixMonth,
    super.saveNineMonth,
    super.category,
    super.finalPrice,
    super.offerPrice,
    super.numberOfCars,
    super.images,
    super.offerDateFrom,
    super.offerDateTo,
    super.notValidFrom,
    super.notValidTo,
    super.cityBranch,
    super.offerDaysNumbers,
    super.customer,
    super.validCar,
    super.inOffer,
    super.attributes,
    super.errorMessage,
    super.available,
    super.error,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      carImagesId: json["car_images_id"],
      carImages: json["car_images"] == null
          ? null
          : CarImagesModel.fromJson(json["car_images"]),
      cities: (json['cities'] as List?)
          ?.map((city) => CityModel.fromJson(city))
          .toList(),
      brandNameEn: json['brand_name_en'],
      brandNameAr: json['brand_name_ar'],
      modelNameEn: json['model_name_en'],
      modelNameAr: json['model_name_ar'],
      year: json['year'],
      price: (json['price'] as num?)?.toDouble(),
      weeklyPrice: (json['weekly_price'] as num?)?.toDouble(),
      oneMonthPrice: (json['one_month_price'] as num?)?.toDouble(),
      threeMonthPrice: (json['three_month_price'] as num?)?.toDouble(),
      sixMonthPrice: (json['six_month_price'] as num?)?.toDouble(),
      nineMonthPrice: (json['nine_month_price'] as num?)?.toDouble(),
      saveThreeMonth: (json['save_three_month'] as num?)?.toDouble(),
      saveSixMonth: (json['save_six_month'] as num?)?.toDouble(),
      saveNineMonth: (json['save_nine_month'] as num?)?.toDouble(),
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      offerPrice: (json['offer_price'] as num?)?.toDouble(),
      numberOfCars: json['number_of_cars'],
      images: (json['images'] as List?)?.cast<String>(),
      offerDateFrom: json['offer_date_from'],
      offerDateTo: json['offer_date_to'],
      notValidFrom: json['not_valid_from'],
      notValidTo: json['not_valid_to'],
      cityBranch: json['city_branch'],
      offerDaysNumbers: json['offer_days_numbers'],
      customer: json['customer'] != null
          ? CustomerModel.fromJson(json['customer'])
          : null,
      validCar: json['valid_car'],
      inOffer: json['in_offer'],
      attributes: (json['attributes'] as List?)
          ?.map((attr) => AttributeModel.fromJson(attr))
          .toList(),
      errorMessage: json['error_message'] != null
          ? ErrorMessageModel.fromJson(json['error_message'])
          : null,
      available: json['available'],
      error: json['error'],
    );
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.imagePath,
    super.deleted,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      imagePath: json['image_path'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'image_path': imagePath,
      'deleted': deleted,
    };
  }
}

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.deleted,
    super.createdAt,
    super.logoPath,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      deleted: json['deleted'],
      createdAt: json['created_at'],
      logoPath: json['logo_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'deleted': deleted,
      'created_at': createdAt,
      'logo_path': logoPath,
    };
  }
}

class AttributeModel extends AttributeEntity {
  const AttributeModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.imagePath,
    super.deleted,
    super.customerId,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      imagePath: json['image_path'],
      deleted: json['deleted'],
      customerId: json['customer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'image_path': imagePath,
      'deleted': deleted,
      'customer_id': customerId,
    };
  }
}

class ErrorMessageModel extends ErrorMessageEntity {
  const ErrorMessageModel({
    super.messageEn,
    super.messageAr,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      messageEn: json['message_en'],
      messageAr: json['message_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_en': messageEn,
      'message_ar': messageAr,
    };
  }
}

class CarImagesModel extends CarImages {
  const CarImagesModel({
    super.id,
    super.brandNameEn,
    super.brandNameAr,
    super.brandId,
    super.modelNameEn,
    super.modelNameAr,
    super.year,
    super.images,
  });

  factory CarImagesModel.fromJson(Map<String, dynamic> json) => CarImagesModel(
        id: json["id"],
        brandNameEn: json["brand_name_en"],
        brandNameAr: json["brand_name_ar"],
        brandId: json["brand_id"],
        modelNameEn: json["model_name_en"],
        modelNameAr: json["model_name_ar"],
        year: json["year"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name_en": brandNameEn,
        "brand_name_ar": brandNameAr,
        "brand_id": brandId,
        "model_name_en": modelNameEn,
        "model_name_ar": modelNameAr,
        "year": year,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
      };
}
