

import 'package:equatable/equatable.dart';

import 'package:cood/features/categories/domain/entity/social_media_links_entity.dart';

class CategoryUserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? image;
  final List<SocialMediaLinkEntity>? socialMediaLinks;

  const CategoryUserEntity({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.socialMediaLinks,
  });
  @override
  List<Object?> get props => [];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
      'socialMediaLinks': socialMediaLinks?.map((x) => x.toJson()).toList(),
    };
  }
}
