import 'package:equatable/equatable.dart';

class AllSocialMediaEntity extends Equatable {
  final int? id;
  final String? name;
  final String? icon;
  final String? color;

  const AllSocialMediaEntity({
    this.id,
    this.name,
    this.icon,
    this.color
  });

  @override
  List<Object?> get props => [id, name, icon,color];
}
