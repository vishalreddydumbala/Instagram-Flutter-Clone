import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NavEvent extends Equatable{
  final int selectedIndex;
  const NavEvent({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}

class NavigateEvent extends NavEvent{
  const NavigateEvent(int selectedIndex):super(selectedIndex: selectedIndex);
}