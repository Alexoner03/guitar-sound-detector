import 'package:firebase_auth/firebase_auth.dart';

class RegisterDto {
   final String name, email, password;

   RegisterDto({
     required this.name,
     required this.email,
     required this.password
   });
}

class AuthResponseDto {
  final String? error;
  final User? user;

  AuthResponseDto(this.error, this.user);
}

class LoginDto {
  final String email, password;

  LoginDto({
    required this.email,
    required this.password
  });
}