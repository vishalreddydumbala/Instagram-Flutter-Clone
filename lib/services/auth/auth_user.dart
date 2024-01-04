import 'package:firebase_auth/firebase_auth.dart' as firebase show User;
import 'package:instagram/services/cloud/cloud_user_db.dart';

class AuthUser {
  final String uid;
  final bool isEmailVerified;
  final String email;
  final String? bio;
  final String? displayName;
  final String? profilePictureUrl;
  final List<dynamic>? followers;
  final List<dynamic>? following;
  const AuthUser(
    this.bio,
    this.profilePictureUrl,
    this.displayName,
    this.followers,
    this.following, {
    required this.uid,
    required this.isEmailVerified,
    required this.email,
  });

  factory AuthUser.fromFirebaseUser(CloudUser clouduser, firebase.User user) {
    return AuthUser(clouduser.bio, clouduser.getProfileImageUrl , clouduser.displayName,
        clouduser.followers, clouduser.following,
        uid: user.uid, isEmailVerified: user.emailVerified, email: user.email!);
  }
}
