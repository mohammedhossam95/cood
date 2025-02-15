import 'package:equatable/equatable.dart';

//-----------ComuniGuideItemEntity refere to Communication Guide item entity
class ComuniGuideItemEntity extends Equatable {
  final String? title;
  final String? image;
const  ComuniGuideItemEntity(this.title, this.image);
  @override
  List<Object?> get props => [];
}
