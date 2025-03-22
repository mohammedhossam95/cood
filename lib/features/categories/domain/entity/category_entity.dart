import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? image;
  final String? icon;

  const CategoryEntity({
    this.id,
    this.nameAr,
    this.nameEn,
    this.image,
    this.icon,
  });
  @override
  List<Object?> get props => [id, nameAr, nameEn, image, icon];
}
