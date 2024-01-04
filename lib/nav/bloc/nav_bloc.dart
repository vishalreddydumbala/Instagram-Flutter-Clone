import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/nav/bloc/nav_event.dart';
import 'package:instagram/nav/bloc/nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(const NavStateHome()) {
    on<NavEvent>((event, emit) {
      if (event is NavigateEvent) {
        switch (event.selectedIndex) {
          case 0:
            emit(const NavStateHome());
            break;
          case 1:
            emit(const NavStateSearch());
            break;
          case 2:
            emit(const NavStateAddPost());
            break;
          case 3:
            emit(const NavStateReels());
            break;
          case 4:
            emit(const NavStateProfile());
            break;
          default:
            emit(const NavStateHome());
        }
      }
    });
  }
}
