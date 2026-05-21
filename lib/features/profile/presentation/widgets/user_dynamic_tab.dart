import 'package:culcul/features/dynamic/dynamic.dart';
import 'package:flutter/material.dart';

class UserDynamicTab extends StatelessWidget {
  final int mid;

  const UserDynamicTab({super.key, required this.mid});

  @override
  Widget build(BuildContext context) {
    return buildUserDynamicFeed(mid: mid);
  }
}
