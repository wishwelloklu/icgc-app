import 'package:equatable/equatable.dart';

abstract class AuthStates extends Equatable {}

class InitialAuthState extends AuthStates {
  @override
  List<Object?> get props => [];
}
