import 'package:cloud_firestore/cloud_firestore.dart';

class CloudPost {
  final String uid;
  final String displayName;
  final String profileImageUrl;
  final String caption;
  final String imageUrl;
  final String datePublished;

  const CloudPost({
    required this.uid,
    required this.displayName,
    required this.profileImageUrl,
    required this.caption,
    required this.imageUrl,
    required this.datePublished,
  });

  CloudPost.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        displayName = snapshot['displayName'],
        profileImageUrl = snapshot['profileImageUrl'],
        caption = snapshot['caption'],
        imageUrl = snapshot['imageUrl'],
        datePublished = snapshot['datePublished'];
}
