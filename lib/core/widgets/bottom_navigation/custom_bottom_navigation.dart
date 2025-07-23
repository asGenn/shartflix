import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bottom_navigation_bloc.dart';

class CustomBottomNavigation extends StatelessWidget {
  final List<NavigationItem> items;
  final Function(int)? onTap;

  const CustomBottomNavigation({super.key, required this.items, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.currentIndex,
          onTap: (index) {
            context.read<BottomNavigationBloc>().add(ChangeTabEvent(index));
            onTap?.call(index);
          },
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: items
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  const NavigationItem({required this.icon, required this.label});
}
