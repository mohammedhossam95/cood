import 'package:equatable/equatable.dart';

class SocialMediaEntity extends Equatable {
  final int? id;
  final String? platform;
  final String? icon;
  final String? link;

  const SocialMediaEntity({
    this.id,
    this.platform,
    this.icon,
    this.link,
  });

  @override
  List<Object?> get props => [id, platform, icon, link];
}