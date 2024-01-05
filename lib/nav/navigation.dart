import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/constants/navigation_list.dart';
import 'package:instagram/nav/bloc/nav_bloc.dart';
import 'package:instagram/nav/bloc/nav_event.dart';
import 'package:instagram/nav/bloc/nav_state.dart';
import 'package:instagram/services/auth/auth_user.dart';
import 'package:instagram/services/bloc/auth_bloc.dart';
import 'package:instagram/services/bloc/auth_state.dart';
import 'package:instagram/utilities/colors.dart';
import 'package:instagram/widgets/profile_icon_widget.dart';

class Navigation extends StatefulWidget {
  final AuthUser authUser;

  const Navigation({Key? key, required this.authUser}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late AuthUser _user;
  final iconColor = const Color.fromARGB(222, 255, 255, 255);

  @override
  void initState() {
    super.initState();
    _user = widget.authUser;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedIn) {
          _user = state.user;
        }
      },
      child: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return Scaffold(
            body: navPages[state.selectedIndex],
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(top: 15),
              child: CupertinoTabBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      color: iconColor,
                    ),
                    activeIcon: Icon(
                      Icons.home_sharp,
                      color: iconColor,
                    ),
                    backgroundColor: iconColor,
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search, color: iconColor),
                    activeIcon: Icon(
                      Icons.search,
                      color: iconColor,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: iconColor,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon:
                        Icon(Icons.video_collection_outlined, color: iconColor),
                    activeIcon: Icon(Icons.video_collection, color: iconColor),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: UserProfileIconWidget(
                      imageUrl: _user.profilePictureUrl,
                    ),
                    activeIcon: UserProfileIconWidget(
                      imageUrl: _user.profilePictureUrl,
                      onFocus: true,
                    ),
                    label: '',
                  ),
                ],
                backgroundColor: mobileBackgroundColor,
                currentIndex: state.selectedIndex,
                onTap: (index) {
                  context.read<NavBloc>().add(NavigateEvent(index));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
