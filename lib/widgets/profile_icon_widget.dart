import 'package:flutter/material.dart';
import 'package:instagram/helper/avatar_builder.dart';
class UserProfileIconWidget extends StatelessWidget {
  final String? imageUrl;
  final bool onFocus;

  const UserProfileIconWidget({
    super.key,
    this.imageUrl,
    this.onFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        backgroundBlendMode: BlendMode.clear,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 20,
        child: Stack(
          children: [
            onFocus == true && imageUrl == null
                ? const Icon(
                    Icons.person_2, // Use your desired placeholder icon
                    color: Colors.white,
                    size: 30,
                  )
                : const Icon(Icons.person_2_outlined,
                    color: Colors.white, size: 30),
            if (imageUrl != null)
              onFocus == true
                  ? Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.white, width: 2))),
                      child: AvatarBuilder.buildAvatar(imageUrl: imageUrl!),
                    )
                  : AvatarBuilder.buildAvatar(imageUrl: imageUrl!)
          ],
        ),
      ),
    );
  }
}
