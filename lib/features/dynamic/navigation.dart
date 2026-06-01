import 'package:culcul/features/dynamic/presentation/pages/article_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/pages/topic_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:flutter/widgets.dart';

Widget buildDynamicNavigationScope({
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required ValueChanged<int> onOpenLiveRoom,
  required ValueChanged<String> onOpenDynamicDetail,
  required void Function(String url, String? title) onOpenArticle,
  required void Function(int topicId, String topicName) onOpenTopic,
  required Widget child,
}) {
  return DynamicNavigationScope(
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    onOpenLiveRoom: onOpenLiveRoom,
    onOpenDynamicDetail: onOpenDynamicDetail,
    onOpenArticle: onOpenArticle,
    onOpenTopic: onOpenTopic,
    child: child,
  );
}

Widget buildArticleDetailRoutePage({required String url, String? title}) {
  return ArticleDetailPage(url: url, title: title);
}

Widget buildTopicDetailRoutePage({
  required int topicId,
  required String topicName,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required ValueChanged<int> onOpenLiveRoom,
  required ValueChanged<String> onOpenDynamicDetail,
  required void Function(String url, String? title) onOpenArticle,
  required void Function(int topicId, String topicName) onOpenTopic,
}) {
  return buildDynamicNavigationScope(
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    onOpenLiveRoom: onOpenLiveRoom,
    onOpenDynamicDetail: onOpenDynamicDetail,
    onOpenArticle: onOpenArticle,
    onOpenTopic: onOpenTopic,
    child: TopicDetailPage(topicId: topicId, topicName: topicName),
  );
}
