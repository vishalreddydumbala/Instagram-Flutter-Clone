import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_bloc.dart';
import 'package:instagram/nav/bloc/nav_bloc.dart';
import 'package:instagram/nav/navigation.dart';
import 'package:instagram/services/auth/auth_service.dart';
import 'package:instagram/services/bloc/auth_bloc.dart';
import 'package:instagram/services/bloc/auth_event.dart';
import 'package:instagram/services/bloc/auth_state.dart';
import 'package:instagram/utilities/colors.dart';
import 'package:instagram/views/authViews/login_view.dart';
import 'package:instagram/views/authViews/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(AuthService.firebase()),
            ),
            BlocProvider(
              create: (context) => NavBloc(),
            ),
            BlocProvider(
              create: (context) => AddPostSubBloc(),
            )
          ],
          child: const HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitalise());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return Navigation(authUser: state.user);
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateSigningUp) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
