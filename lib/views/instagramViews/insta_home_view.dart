import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/services/bloc/auth_bloc.dart';
import 'package:instagram/services/bloc/auth_event.dart';

class InstagramHomeView extends StatefulWidget {
  const InstagramHomeView({super.key});

  @override
  State<InstagramHomeView> createState() => _InstagramHomeViewState();
}

class _InstagramHomeViewState extends State<InstagramHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogout());
            },
            child: const Text('Logout')),
      ),
    );
  }
}
