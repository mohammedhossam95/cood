import 'package:equatable/equatable.dart';

class FriendEntity extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? code;
  final String? image;
  final int? friendshipId;
  final List<String>? socialMediaLinks;
  final FriendshipInfoEntity? friendshipInfo;

  const FriendEntity({
    this.id,
    this.name,
    this.phone,
    this.code,
    this.image,
    this.friendshipId,
    this.socialMediaLinks,
    this.friendshipInfo,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        code,
        image,
        friendshipId,
        socialMediaLinks,
        friendshipInfo,
      ];
}

class FriendshipInfoEntity extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final bool? isSender;

  const FriendshipInfoEntity({
    this.id,
    this.createdAt,
    this.isSender,
  });

  @override
  List<Object?> get props => [id, createdAt, isSender];
}