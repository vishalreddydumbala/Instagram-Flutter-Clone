import 'package:flutter/material.dart';

class InstagramSearchView extends StatefulWidget {
  const InstagramSearchView({super.key});

  @override
  State<InstagramSearchView> createState() => _InstagramSearchViewState();
}

class _InstagramSearchViewState extends State<InstagramSearchView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Search'),
      ),
    );
  }
}
