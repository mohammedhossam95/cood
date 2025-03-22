import 'package:equatable/equatable.dart';

class SocialMediaEntity extends Equatable {
  final int? id;
  final String? platform;
  final String? icon;
  final String? link;
  final String? color;
  final String? inputType;

  const SocialMediaEntity({
    this.id,
    this.platform,
    this.icon,
    this.link,
    this.color,
    this.inputType,
  });

  @override
  List<Object?> get props => [id, platform, icon, link,color,inputType];
}