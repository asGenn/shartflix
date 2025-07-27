part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends BottomNavigationEvent {
  final int index;

  ChangeTabEvent(this.index);

  @override
  List<Object> get props => [index];
}
