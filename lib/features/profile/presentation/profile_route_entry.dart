import 'package:culcul/features/profile/presentation/profile_page.dart';
import 'package:culcul/features/profile/presentation/relation/followers_page.dart';
import 'package:culcul/features/profile/presentation/relation/followings_page.dart';
import 'package:culcul/features/profile/presentation/user_profile_page.dart';
import 'package:flutter/widgets.dart';

Widget buildProfileRoutePage() => const ProfilePage();

Widget buildFollowingsRoutePage(int vmid) => FollowingsPage(vmid: vmid);

Widget buildFollowersRoutePage(int vmid) => FollowersPage(vmid: vmid);

Widget buildUserProfileRoutePage(int mid) => UserProfilePage(mid: mid);
