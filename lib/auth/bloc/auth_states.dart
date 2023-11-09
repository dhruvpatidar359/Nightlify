part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class UnAuthenticated extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GoogleAuthSuccessState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GoogleAuthFailedState extends AuthState {
  final String error;
  GoogleAuthFailedState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GoogleAuthLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailPasswordRegisterLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailPasswordRegisterSuccessState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailPasswordRegisterFailedState extends AuthState {
  final String error;

  EmailPasswordRegisterFailedState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class EmailPasswordLoginLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailPasswordLoginSuccessState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailPasswordLoginFailedState extends AuthState {
  final String error;
  EmailPasswordLoginFailedState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
