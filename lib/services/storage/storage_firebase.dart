import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/services/storage/storage_exception.dart';

@immutable
class StorageFirebase {
  final _firebaseStorage = FirebaseStorage.instance;

  static final StorageFirebase _instance = StorageFirebase._internal();
  StorageFirebase._internal();

  factory StorageFirebase() => _instance;

  Future<String?> uploadProfileImage(String uid, Uint8List? image) async {
    try {
      if (image == null) return null;
      final ref = _firebaseStorage.ref().child("profile_images").child(uid);
      final uploadTask = ref.putData(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw CouldNotUploadProfileImageException();
    }
  }

  Future<String> getProfileImage(String uid) async {
    final ref = _firebaseStorage.ref().child("profile_images").child(uid);
    return await ref.getDownloadURL();
  }
}
