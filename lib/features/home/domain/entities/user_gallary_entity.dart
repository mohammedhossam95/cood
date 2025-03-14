import 'package:equatable/equatable.dart';

class UserGalleryEntity extends Equatable {
  final int? id;
  final int? userId;
  final String? imagePath;
  final String? caption;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;

  const UserGalleryEntity({
    this.id,
    this.userId,
    this.imagePath,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, userId, imagePath, caption, createdAt, updatedAt, imageUrl];

}
