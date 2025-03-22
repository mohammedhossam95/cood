// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SocialMediaLinkEntity extends Equatable {
  final int? id;
  final String? platform;
  final String? link;
  final String? icon;
  final String? color;

  const SocialMediaLinkEntity({
    this.id,
    this.platform,
    this.link,
    this.icon,
    this.color,
  });
  @override
  List<Object?> get props => [id, platform, link, icon, color];
}
