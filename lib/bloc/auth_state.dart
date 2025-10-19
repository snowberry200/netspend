import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String email;
  final String password;

  const Authenticated({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class Unauthenticated extends AuthState {
  final String message;

  const Unauthenticated(this.message);

  @override
  List<Object?> get props => [message];
}

class SignUpSuccess extends AuthState {
  final String name;
  final String email;
  final String password;

  const SignUpSuccess(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

class CheckBoxState extends AuthState {
  final bool isChecked;

  const CheckBoxState({this.isChecked = false});

  @override
  List<Object?> get props => [isChecked];
}
