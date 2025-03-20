
import 'package:equatable/equatable.dart';

import 'package:cood/features/categories/domain/entity/category_entity.dart';
import 'package:cood/features/categories/domain/entity/category_user_entity.dart';

class ResultEntity extends Equatable {
  final CategoryEntity? category;
  final List<CategoryUserEntity>? users;

  const ResultEntity({
    this.category,
    this.users,
  });

  @override
  List<Object?> get props => [category, users];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category': category?.toJson(),
      'users': users?.map((x) => x.toJson()).toList(),
    };
  }
}
