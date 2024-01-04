import 'dart:typed_data';

import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitalise extends AuthEvent {
  const AuthEventInitalise();
}

class AuthEventRegister extends AuthEvent {
  final String userName;
  final String email;
  final String password;
  final String? bio;
  final Uint8List? profilePic;

  const AuthEventRegister({
    required this.userName,
    required this.email,
    required this.password,
    this.bio,
    this.profilePic,
  });
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin({
    required this.email,
    required this.password,
  });
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventForgetPassword extends AuthEvent {
  final String? email;
  const AuthEventForgetPassword({required this.email});
}

class AuthEventShouldLogin extends AuthEvent {
  const AuthEventShouldLogin();
}
