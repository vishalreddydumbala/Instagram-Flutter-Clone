import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/services/auth/auth_exceptions.dart';
import 'package:instagram/services/auth/auth_provider.dart';
import 'package:instagram/services/auth/auth_user.dart';
import 'package:instagram/services/cloud/cloud_exceptions.dart';
import 'package:instagram/services/cloud/cloud_user_db.dart';
import 'package:instagram/services/cloud/firebase_cloud.dart';

class FirebaseAuthProvider implements AuthProvider {
  static final _singelton = FirebaseAuthProvider._internal();

  factory FirebaseAuthProvider() => _singelton;

  FirebaseAuthProvider._internal();

  CloudUser? _cloudUser;

  @override
  Future<void> initialise() async {
    await Firebase.initializeApp();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && _cloudUser == null) {
      if (user.emailVerified == false) {
        await FirebaseAuth.instance.signOut();
      }
      _cloudUser = await FirebaseCloud().getUser(ownerUid: user.uid);
    }
  }

  ///[createUser] creates a new user in Firebase Authentication
  //todo: handle try block for clouduser
  @override
  Future<AuthUser> createUser({
    required String userName,
    required String email,
    required String password,
    String? bio,
    Uint8List? profilePic,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          final cloudUser = await FirebaseCloud().createNewUser(
            ownerUid: user.uid,
            email: email,
            displayName: userName,
            bio: bio,
            image: profilePic,
          );
          return AuthUser.fromFirebaseUser(cloudUser, user);
        } catch (e) {
          try {
            await user.delete();
            await FirebaseCloud().deleteUser(ownerUid: user.uid);
          } catch (_) {
            rethrow;
          }
          rethrow;
        }
      } else {
        throw GenericAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          throw WeakPasswordAuthException();
        case "email-already-in-use":
          throw EmailAlreadyInUseAuthException();
        case "invalid-email":
          throw InvalidEmailAuthException();
        default:
          throw GenericAuthException();
      }
    } on CloudException catch (_) {
      throw CloudAuthException();
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && _cloudUser != null) {
      return AuthUser.fromFirebaseUser(_cloudUser!, user);
    } else {
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _cloudUser = null;
      return await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<AuthUser> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final cloudUser = await FirebaseCloud().getUser(ownerUid: user.uid);
        return AuthUser.fromFirebaseUser(cloudUser, user);
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      switch (e.code) {
        case "INVALID_LOGIN_CREDENTIALS":
          throw InvalidLoginCredentialsAuthException();
        case "wrong-password":
          throw WrongPasswordAuthException();
        case "invalid-email":
          throw InvalidEmailAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.sendEmailVerification();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendPasswordReset({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          throw UserNotFoundAuthException();
        case "invalid-email":
          throw InvalidEmailAuthException();
        case "missing-email":
          throw MissingEmailAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
