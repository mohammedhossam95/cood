// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SocialEntity extends Equatable {
  final String? name;
  final String? email;
  final String? image;
  
  const SocialEntity({this.name, this.email, this.image,});

  @override
  List<Object?> get props => [name, email, image];
}
