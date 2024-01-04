import 'package:flutter/material.dart';

@immutable
class CustomSnackBar {
  final String errorText;
  final Color bgColor;

  const CustomSnackBar({required this.errorText, required this.bgColor});

  void show(BuildContext context) {
    final snackbar = SnackBar(
        content: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Oh Snap!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        errorText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            )),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ));

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
