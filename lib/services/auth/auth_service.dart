import 'dart:typed_data';

import 'package:instagram/services/auth/auth_provider.dart';
import 'package:instagram/services/auth/auth_user.dart';
import 'package:instagram/services/auth/firebase_auth_provider.dart';

class AuthService {
  final AuthProvider _provider;
  const AuthService(this._provider);

  static final AuthService _singelton  = AuthService._internal(FirebaseAuthProvider());

  factory AuthService.firebase() => _singelton;

  AuthService._internal(this._provider);
  
  Future<void> initialise() => _provider.initialise();

  
  Future<AuthUser> createUser({
    required String userName,
    required String email,
    required String password,
    String? bio,
    Uint8List? profilePic,
  }) =>
      _provider.createUser(
        userName: userName,
        email: email,
        password: password,
        bio: bio,
        profilePic: profilePic,
      );

  
  AuthUser? get currentUser => _provider.currentUser;

  
  Future<void> logOut() => _provider.logOut();

  
  Future<AuthUser> login({required String email, required String password}) =>
      _provider.login(email: email, password: password);

  
  Future<void> sendEmailVerification() => _provider.sendEmailVerification();

  
  Future<void> sendPasswordReset({required String email}) =>
      _provider.sendPasswordReset(email: email);
}
