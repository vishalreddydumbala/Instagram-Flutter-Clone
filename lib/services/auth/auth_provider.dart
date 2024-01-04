import 'dart:typed_data';

import 'package:instagram/services/auth/auth_user.dart';

abstract class AuthProvider{
  Future<void> initialise();

  AuthUser? get currentUser;

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String userName, 
    required String email,
    required String password,
    String? bio,
    Uint8List? profilePic,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordReset({required String email});
}