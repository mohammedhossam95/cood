import 'package:cood/features/auth/domain/entities/login_response.dart';
import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final int? id;
  final User? user;
  final String? mediaUrl;
  final String? videoThumbnail;
  final String? mediaType;
  final DateTime? createdAt;
  final DateTime? expiresAt;

  const Story({
    this.id,
    this.user,
    this.mediaUrl,
    this.videoThumbnail,
    this.mediaType,
    this.createdAt,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        mediaUrl,
        videoThumbnail,
        mediaType,
        createdAt,
        expiresAt,
      ];
}
