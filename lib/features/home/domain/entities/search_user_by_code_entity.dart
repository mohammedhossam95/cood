import 'package:equatable/equatable.dart';

class SearchUserByCodeEntity extends Equatable {
  final int? id;
  final String? name;
  final String? code;
  final dynamic image;
  final String? friendshipStatus;
  
 const  SearchUserByCodeEntity({
    this.id,
    this.name,
    this.code,
    this.image,
    this.friendshipStatus,
  });
  
  

  @override
  List<Object?> get props => [id,name,code,image,friendshipStatus];

  
}
