import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final bool? deleted;

  const CityEntity({
    this.id,
    this.nameEn,
    this.nameAr,
    this.deleted,
  });

  @override
  List<Object?> get props => [id, nameEn, nameAr, deleted];
}
