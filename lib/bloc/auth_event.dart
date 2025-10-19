import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpRequested(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}

class CheckAuthStatus extends AuthEvent {}

class CheckBoxEvent extends AuthEvent {
  final bool isChecked;

  const CheckBoxEvent({this.isChecked = true});

  @override
  List<Object?> get props => [isChecked];
}
