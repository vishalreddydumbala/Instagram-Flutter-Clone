import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/constants/cloud_collection.dart';
import 'package:instagram/services/cloud/cloud_exceptions.dart';
import 'package:instagram/services/cloud/cloud_user_db.dart';
import 'package:instagram/services/storage/storage_exception.dart';
import 'package:instagram/services/storage/storage_firebase.dart';

class FirebaseCloud {
  final users = FirebaseFirestore.instance.collection('users');
  final storage = StorageFirebase();

  static final FirebaseCloud _instance = FirebaseCloud._sharedInstance();

  FirebaseCloud._sharedInstance();

  factory FirebaseCloud() => _instance;

  Future<CloudUser> createNewUser(
      {required String ownerUid,required String email,required displayName,String? bio , Uint8List? image}) async {
    try {
      final imageUrl = await storage.uploadProfileImage(ownerUid, image);
      await users.doc(ownerUid).set(
        {
          userId: ownerUid,
          userEmail: email,
          userDisplayName: displayName,
          userBio: bio ?? '',
          userFollowers: [],
          userFollowing: [],
          userProfileImageUrl: imageUrl ?? '',
        },
      );
      final fetchNote = await users.doc(ownerUid).get();
      return CloudUser.fromSnapshot(fetchNote);
    } on StorageException catch (_) {
      rethrow;
    } catch (e) {
      throw CouldNotCreateCloudUserException();
    }
  }

  Future<CloudUser> getUser({required String ownerUid}) async {
    try {
      final fetchNote = await users.doc(ownerUid).get();
      return CloudUser.fromSnapshot(fetchNote);
    } catch (e) {
      throw CouldNotFetchCloudUserException();
    }
  }

  Future<void> updateUser({required CloudUser cloudUser}) async {
    try {
      await users.doc(cloudUser.uid).update(
        {
          userId: cloudUser.uid,
          userEmail: cloudUser.email,
          userDisplayName: cloudUser.displayName,
          userBio: cloudUser.bio,
          userFollowers: cloudUser.followers,
          userFollowing: cloudUser.following,
          userProfileImageUrl: cloudUser.profileImageUrl,
        },
      );
    } catch (e) {
      throw CouldNotUpdateCloudUserException();
    }
  }

  Future<void> deleteUser({required String ownerUid}) async {
    try {
      await users.doc(ownerUid).delete();
    } catch (e) {
      throw CouldNotDeleteCloudUserException();
    }
  }
}
