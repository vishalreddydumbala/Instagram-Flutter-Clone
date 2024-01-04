import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/services/auth/auth_service.dart';
import 'package:instagram/services/bloc/auth_event.dart';
import 'package:instagram/services/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthService auth)
      : super(const AuthStateUnInitialiesed(
            hasMessage: false, isLoading: false)) {
    on<AuthEventInitalise>((event, emit) async {
      await auth.initialise();
      final user = auth.currentUser;
      if (user != null) {
        if (user.isEmailVerified) {
          emit(AuthStateLoggedIn(
              user: user, hasMessage: false, isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(hasMessage: true, isLoading: false));
        }
      } else {
        emit(const AuthStateLoggedOut(hasMessage: false, isLoading: false));
      }
    });

    on<AuthEventRegister>((event, emit) async {
      try {
        await auth.createUser(
            userName: event.userName,
            email: event.email,
            password: event.password,
            bio: event.bio,
            profilePic: event.profilePic);
        await auth.sendEmailVerification();
        emit(const AuthStateLoggedOut(hasMessage: true, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateSigningUp(
            exception: e, hasMessage: false, isLoading: false));
      }
    });

    on<AuthEventLogin>((event, emit) async {
      try {
        final user = await auth.login(
          email: event.email,
          password: event.password,
        );
        if (user.isEmailVerified) {
          emit(AuthStateLoggedIn(
              user: user, hasMessage: false, isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(hasMessage: true, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
            exception: e, hasMessage: false, isLoading: false));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      await auth.logOut();
      emit(const AuthStateLoggedOut(hasMessage: false, isLoading: false));
    });

    on<AuthEventShouldRegister>(((event, emit) {
      emit(const AuthStateSigningUp(hasMessage: false, isLoading: false));
    }));

    on<AuthEventShouldLogin>((event, emit) {
      emit(const AuthStateLoggedOut(hasMessage: false, isLoading: false));
    });

    on<AuthEventSendEmailVerification>((event, emit) {
      // auth.sendEmailVerification();
      emit(const AuthStateLoggedOut(hasMessage: false, isLoading: false));
    });
  }
}
