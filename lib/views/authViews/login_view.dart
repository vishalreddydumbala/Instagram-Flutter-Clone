import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/services/bloc/auth_bloc.dart';
import 'package:instagram/services/bloc/auth_event.dart';
import 'package:instagram/services/bloc/auth_state.dart';
import 'package:instagram/utilities/colors.dart';
import 'package:instagram/utilities/custom_snackbar_message.dart';
import 'package:instagram/widgets/text_field_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  void login() {
    context.read<AuthBloc>().add(AuthEventLogin(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          if (state.hasMessage) {
            const CustomSnackBar(
                    errorText:
                        "Please verify your email address by clicking on the link sent to your email",
                    bgColor: Colors.blue)
                .show(context);
            context
                .read<AuthBloc>()
                .add(const AuthEventSendEmailVerification());
          }
          if (state.exception != null) {
            const CustomSnackBar(
                    errorText: "Please check your email and password",
                    bgColor: Colors.red)
                .show(context);
          }
        }
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(flex: 1, child: Container()),
            SvgPicture.asset(
              "assets/ic_instagram.svg",
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              height: 64,
            ),
            const SizedBox(height: 30),
            TextFieldInput(
                controller: _emailController,
                hint: 'Username',
                textType: TextInputType.emailAddress,
                isPassword: false),
            const SizedBox(height: 20),
            TextFieldInput(
                controller: _passwordController,
                hint: 'Password',
                textType: TextInputType.visiblePassword,
                isPassword: true),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: login,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue),
                child: const Text("Log In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Flexible(flex: 1, child: Container()),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventShouldRegister());
                      },
                      child: const Text('Sign up',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)))
                ],
              ),
            )
          ]),
        ),
      )),
    );
  }
}
