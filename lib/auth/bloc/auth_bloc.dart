import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nightlify/auth/data/authRepository/authentication_repository.dart';

part 'auth_event.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<GoogleSignInEvent>((event, state) async {
      emit(GoogleAuthLoadingState());
      String success = await authRepository.signInWithGoogle();

      if (success == "") {
        emit(GoogleAuthSuccessState());
      } else {
        emit(GoogleAuthFailedState(success));
      }
    });

    on<EmailPasswordRegisterEvent>((event, state) async {
      emit(EmailPasswordRegisterLoadingState());
      String success =
          await authRepository.registerUser(event.email, event.password);

      if (success.isEmpty) {
        emit(EmailPasswordRegisterSuccessState());
      } else {
        emit(EmailPasswordRegisterFailedState(success));
      }
    });

    on<SignOutEvent>((event, state) async {
      emit(AuthLoadingState());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });

    on<EmailPasswordLoginEvent>((event, state) async {
      emit(EmailPasswordLoginLoadingState());
      final success =
          await authRepository.signInUser(event.email, event.password);

      if (success.runtimeType.toString() == 'String') {
        emit(EmailPasswordLoginFailedState(success));
      } else {
        emit(EmailPasswordLoginSuccessState());
      }
    });
  }
}
