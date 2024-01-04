import 'package:cloud_firestore/cloud_firestore.dart';

class CloudUser {
  final String uid;
  final String email;
  final String displayName;
  final String bio;
  final List<dynamic> followers;
  final List<dynamic> following;
  final String? profileImageUrl;

  const CloudUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.bio,
    required this.followers,
    required this.following,
    this.profileImageUrl,
  });

  CloudUser.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        email = snapshot['email'],
        displayName = snapshot['displayName'],
        bio = snapshot['bio'] == '' ? null : snapshot['bio'],
        followers = snapshot['followers'],
        following = snapshot['following'],
        profileImageUrl = snapshot['profileImageUrl'] == '' ? null : snapshot['profileImageUrl'];

  String get getUid => uid;
  String get getEmail => email;
  String get getDisplayName => displayName;
  String get getBio => bio;
  List<dynamic> get getFollowers => followers;
  List<dynamic> get getFollowing => following;
  String? get getProfileImageUrl => profileImageUrl;
}
