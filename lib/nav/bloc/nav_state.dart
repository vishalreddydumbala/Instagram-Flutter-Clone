import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NavState extends Equatable{
  final int selectedIndex;
  const NavState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

class NavStateHome extends NavState{
  const NavStateHome():super(0);
}

class NavStateSearch extends NavState{
  const NavStateSearch():super(1);
}

class NavStateAddPost extends NavState{
  const NavStateAddPost():super(2);
}

class NavStateReels extends NavState{
  const NavStateReels():super(3);
}

class NavStateProfile extends NavState{
  const NavStateProfile():super(4);
}
