import 'package:flutter/widgets.dart';

class DynamicNavigationScope extends InheritedWidget {
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;
  final ValueChanged<int> onOpenLiveRoom;
  final ValueChanged<String> onOpenDynamicDetail;
  final void Function(String url, String? title) onOpenArticle;
  final void Function(int topicId, String topicName) onOpenTopic;

  const DynamicNavigationScope({
    super.key,
    required this.onOpenUser,
    required this.onOpenVideo,
    required this.onOpenLiveRoom,
    required this.onOpenDynamicDetail,
    required this.onOpenArticle,
    required this.onOpenTopic,
    required super.child,
  });

  static DynamicNavigationScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DynamicNavigationScope>();
    assert(scope != null, 'DynamicNavigationScope is missing from the widget tree.');
    return scope!;
  }

  @override
  bool updateShouldNotify(DynamicNavigationScope oldWidget) {
    return onOpenUser != oldWidget.onOpenUser ||
        onOpenVideo != oldWidget.onOpenVideo ||
        onOpenLiveRoom != oldWidget.onOpenLiveRoom ||
        onOpenDynamicDetail != oldWidget.onOpenDynamicDetail ||
        onOpenArticle != oldWidget.onOpenArticle ||
        onOpenTopic != oldWidget.onOpenTopic;
  }
}
