// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  final String icon;

const CategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.icon,
  });
  @override
  List<Object?> get props => [id, nameAr, nameEn, image, icon];
}
