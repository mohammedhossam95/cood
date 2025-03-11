import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  final String? name;
  final String? phone;
  final String? password;
  final String? passwordConfirm;
  final String? token;
  final String? userType;

  const AuthParams({
    this.name,
    this.phone,
    this.password,
    this.passwordConfirm,
    this.token,
    this.userType,
  });

  @override
  List<Object?> get props => <Object?>[
        name,
        phone,
        password,
        passwordConfirm,
        token,
        userType,
      ];

  Map<String, dynamic> toJson() => {
        'phone': phone,
        "password": password,
        "fcm_device_key": token,
      };
}
