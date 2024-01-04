import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instagram/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final bool hasMessage;
  const AuthState(this.hasMessage, this.isLoading);
}

class AuthStateUnInitialiesed extends AuthState {
  const AuthStateUnInitialiesed(
      {required bool hasMessage, required bool isLoading})
      : super(hasMessage, isLoading);
}

class AuthStateSigningUp extends AuthState {
  final Exception? exception;
  const AuthStateSigningUp(
      {this.exception, required bool hasMessage, required bool isLoading})
      : super(hasMessage, isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(
      {required this.user, required bool hasMessage, required bool isLoading})
      : super(hasMessage, isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut(
      {this.exception, required bool hasMessage, required bool isLoading})
      : super(hasMessage, isLoading);

  @override
  List<Object?> get props => [exception, hasMessage, isLoading];
}
