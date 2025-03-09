import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String? name;
  final String? phone;
  final String? profileImage;

  const ContactEntity({
    required this.name,
    required this.phone,
    required this.profileImage,
  });

  @override
  List<Object?> get props => [name, phone, profileImage];
}
