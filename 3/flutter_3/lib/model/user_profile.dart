import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final DateTime birthday;
  final int? phone;
  final String? instagram;
  final String email;
  final String password;

  const UserProfile({
    required this.name,
    required this.birthday,
    required this.phone,
    required this.instagram,
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [
    name,
    birthday,
    phone,
    instagram,
    email,
    password,
  ];

}
