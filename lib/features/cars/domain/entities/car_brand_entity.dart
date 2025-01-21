import 'package:equatable/equatable.dart';

class CarBrand extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? imagePath;

  const CarBrand({
    this.id,
    this.nameEn,
    this.nameAr,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        imagePath,
      ];
}
