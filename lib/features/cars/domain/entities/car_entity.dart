import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final int? id;
  final int? carImagesId;
  final CarImages? carImages;
  final List<City>? cities;
  final String? brandNameEn;
  final String? brandNameAr;
  final String? modelNameEn;
  final String? modelNameAr;
  final int? year;
  final double? price;
  final double? weeklyPrice;
  final double? oneMonthPrice;
  final double? threeMonthPrice;
  final double? sixMonthPrice;
  final double? nineMonthPrice;
  final double? saveThreeMonth;
  final double? saveSixMonth;
  final double? saveNineMonth;
  final CategoryEntity? category;
  final double? finalPrice;
  final double? offerPrice;
  final int? numberOfCars;
  final List<String>? images;
  final String? offerDateFrom;
  final String? offerDateTo;
  final String? notValidFrom;
  final String? notValidTo;
  final String? cityBranch;
  final int? offerDaysNumbers;
  final CustomerEntity? customer;
  final bool? validCar;
  final bool? inOffer;
  final List<AttributeEntity>? attributes;
  final ErrorMessageEntity? errorMessage;
  final bool? available;
  final bool? error;

  const CarEntity({
    this.id,
    this.carImagesId,
    this.carImages,
    this.cities,
    this.brandNameEn,
    this.brandNameAr,
    this.modelNameEn,
    this.modelNameAr,
    this.year,
    this.price,
    this.weeklyPrice,
    this.oneMonthPrice,
    this.threeMonthPrice,
    this.sixMonthPrice,
    this.nineMonthPrice,
    this.saveThreeMonth,
    this.saveSixMonth,
    this.saveNineMonth,
    this.category,
    this.finalPrice,
    this.offerPrice,
    this.numberOfCars,
    this.images,
    this.offerDateFrom,
    this.offerDateTo,
    this.notValidFrom,
    this.notValidTo,
    this.cityBranch,
    this.offerDaysNumbers,
    this.customer,
    this.validCar,
    this.inOffer,
    this.attributes,
    this.errorMessage,
    this.available,
    this.error,
  });

  @override
  List<Object?> get props => [
        id,
        carImagesId,
        carImages,
        cities,
        brandNameEn,
        brandNameAr,
        modelNameEn,
        modelNameAr,
        year,
        price,
        weeklyPrice,
        oneMonthPrice,
        threeMonthPrice,
        sixMonthPrice,
        nineMonthPrice,
        saveThreeMonth,
        saveSixMonth,
        saveNineMonth,
        category,
        finalPrice,
        offerPrice,
        numberOfCars,
        images,
        offerDateFrom,
        offerDateTo,
        notValidFrom,
        notValidTo,
        cityBranch,
        offerDaysNumbers,
        customer,
        validCar,
        inOffer,
        attributes,
        errorMessage,
        available,
        error,
      ];
}

class City extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final bool? deleted;

  const City({
    this.id,
    this.nameEn,
    this.nameAr,
    this.deleted,
  });

  @override
  List<Object?> get props => [id, nameEn, nameAr, deleted];
}

class CategoryEntity extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? imagePath;
  final bool? deleted;

  const CategoryEntity({
    this.id,
    this.nameEn,
    this.nameAr,
    this.imagePath,
    this.deleted,
  });

  @override
  List<Object?> get props => [id, nameEn, nameAr, imagePath, deleted];
}

class CustomerEntity extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final bool? deleted;
  final String? createdAt;
  final String? logoPath;

  const CustomerEntity({
    this.id,
    this.nameEn,
    this.nameAr,
    this.deleted,
    this.createdAt,
    this.logoPath,
  });

  @override
  List<Object?> get props => [id, nameEn, nameAr, deleted, createdAt, logoPath];
}

class AttributeEntity extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? imagePath;
  final bool? deleted;
  final int? customerId;

  const AttributeEntity({
    this.id,
    this.nameEn,
    this.nameAr,
    this.imagePath,
    this.deleted,
    this.customerId,
  });

  @override
  List<Object?> get props =>
      [id, nameEn, nameAr, imagePath, deleted, customerId];
}

class ErrorMessageEntity extends Equatable {
  final String? messageEn;
  final String? messageAr;

  const ErrorMessageEntity({
    this.messageEn,
    this.messageAr,
  });

  @override
  List<Object?> get props => [messageEn, messageAr];
}

class CarImages extends Equatable {
  final int? id;
  final String? brandNameEn;
  final String? brandNameAr;
  final int? brandId;
  final String? modelNameEn;
  final String? modelNameAr;
  final int? year;
  final List<String>? images;

  const CarImages({
    this.id,
    this.brandNameEn,
    this.brandNameAr,
    this.brandId,
    this.modelNameEn,
    this.modelNameAr,
    this.year,
    this.images,
  });

  @override
  List<Object?> get props => [
        id,
        brandNameEn,
        brandNameAr,
        brandId,
        modelNameEn,
        modelNameAr,
        year,
        images,
      ];
}
