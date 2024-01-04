import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/helper/profile_image_picker.dart';
import 'package:instagram/services/auth/auth_service.dart';
import 'package:instagram/services/bloc/auth_bloc.dart';
import 'package:instagram/services/bloc/auth_event.dart';
import 'package:instagram/utilities/colors.dart';
import 'package:instagram/widgets/text_field_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  final _userNameController = TextEditingController();
  Uint8List? _profileimage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final Uint8List img = await profilePicker(ImageSource.gallery);
    setState(() {
      _profileimage = img;
    });
  }

  void register() {
    context.read<AuthBloc>().add(AuthEventRegister(
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        profilePic: _profileimage));
    log("user created", name: "register");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(flex: 1, child: Container()),
          SvgPicture.asset(
            "assets/ic_instagram.svg",
            colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            height: 64,
          ),
          const SizedBox(height: 30),

          /// avatar
          Stack(
            children: [
              _profileimage != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(_profileimage!),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fHww'),
                    ),
              Positioned(
                  bottom: -10,
                  right: -8,
                  child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.blue,
                      )))
            ],
          ),
          const SizedBox(height: 20),

          /// Username
          TextFieldInput(
              controller: _userNameController,
              hint: 'Enter your username',
              textType: TextInputType.text,
              isPassword: false),
          const SizedBox(height: 20),

          /// email
          TextFieldInput(
              controller: _emailController,
              hint: 'Enter your email',
              textType: TextInputType.emailAddress,
              isPassword: false),
          const SizedBox(height: 20),

          /// password
          TextFieldInput(
              controller: _passwordController,
              hint: 'Enter your password',
              textType: TextInputType.visiblePassword,
              isPassword: true),
          const SizedBox(height: 20),

          /// bio
          TextFieldInput(
              controller: _bioController,
              hint: 'Enter your bio',
              textType: TextInputType.text,
              isPassword: false),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: register,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue),
              child: const Text("Sign Up",
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
                const Text('Already had an account?'),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogout());
                    },
                    child: const Text('Log in',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)))
              ],
            ),
          )
        ]),
      ),
    ));
  }
}
