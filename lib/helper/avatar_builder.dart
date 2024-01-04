import 'package:flutter/material.dart';

@immutable
class AvatarBuilder {
  static CircleAvatar buildAvatar({required String imageUrl}){
    return CircleAvatar(
      radius: 20,
      backgroundImage: NetworkImage(imageUrl),
      backgroundColor: Colors.transparent,
    );
  }
}