import 'package:flutter/widgets.dart';

typedef OpenProfileChat =
    void Function({required int talkerId, required String name, String? avatarUrl});

class ProfileNavigationScope extends InheritedWidget {
  final VoidCallback onLogin;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenHistory;
  final VoidCallback onOpenFavorites;
  final VoidCallback onOpenToView;
  final ValueChanged<int> onOpenFollowings;
  final ValueChanged<int> onOpenFollowers;
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;
  final OpenProfileChat onOpenChat;

  const ProfileNavigationScope({
    super.key,
    required this.onLogin,
    required this.onOpenSettings,
    required this.onOpenHistory,
    required this.onOpenFavorites,
    required this.onOpenToView,
    required this.onOpenFollowings,
    required this.onOpenFollowers,
    required this.onOpenUser,
    required this.onOpenVideo,
    required this.onOpenChat,
    required super.child,
  });

  static ProfileNavigationScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ProfileNavigationScope>();
    assert(scope != null, 'ProfileNavigationScope is missing from the widget tree.');
    return scope!;
  }

  @override
  bool updateShouldNotify(ProfileNavigationScope oldWidget) {
    return onLogin != oldWidget.onLogin ||
        onOpenSettings != oldWidget.onOpenSettings ||
        onOpenHistory != oldWidget.onOpenHistory ||
        onOpenFavorites != oldWidget.onOpenFavorites ||
        onOpenToView != oldWidget.onOpenToView ||
        onOpenFollowings != oldWidget.onOpenFollowings ||
        onOpenFollowers != oldWidget.onOpenFollowers ||
        onOpenUser != oldWidget.onOpenUser ||
        onOpenVideo != oldWidget.onOpenVideo ||
        onOpenChat != oldWidget.onOpenChat;
  }
}
