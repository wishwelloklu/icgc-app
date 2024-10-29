import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable {}

class LoginEvent extends AuthEvents {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
