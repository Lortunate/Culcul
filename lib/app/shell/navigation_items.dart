import 'package:flutter/material.dart';

class NavigationItem {
  final IconData icon;
  final IconData selectedIcon;

  const NavigationItem({required this.icon, required this.selectedIcon});
}

class NavigationItems {
  static const List<NavigationItem> items = [
    NavigationItem(icon: Icons.home_outlined, selectedIcon: Icons.home_rounded),
    NavigationItem(icon: Icons.explore_outlined, selectedIcon: Icons.explore_rounded),
    NavigationItem(
      icon: Icons.leaderboard_outlined,
      selectedIcon: Icons.leaderboard_rounded,
    ),
    NavigationItem(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
    ),
  ];
}
