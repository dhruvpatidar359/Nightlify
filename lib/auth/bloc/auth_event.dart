part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class GoogleSignInEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailPasswordRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  EmailPasswordRegisterEvent({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailPasswordLoginEvent extends AuthEvent {
  final String email;
  final String password;
  EmailPasswordLoginEvent({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignOutEvent extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
