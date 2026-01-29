import 'package:flutter/material.dart';

class NavigationItem {
  final IconData icon;
  final IconData selectedIcon;

  const NavigationItem({required this.icon, required this.selectedIcon});
}

class NavigationItems {
  static const List<NavigationItem> items = [
    NavigationItem(icon: Icons.home_outlined, selectedIcon: Icons.home),
    NavigationItem(icon: Icons.explore_outlined, selectedIcon: Icons.explore),
    NavigationItem(
      icon: Icons.ondemand_video_outlined,
      selectedIcon: Icons.ondemand_video,
    ),
    NavigationItem(icon: Icons.person_outline, selectedIcon: Icons.person),
  ];
}
