import 'package:culcul/features/dynamic/presentation/pages/dynamic_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/pages/dynamic_page.dart';
import 'package:culcul/features/dynamic/presentation/pages/publish_dynamic_page.dart';
import 'package:culcul/features/dynamic/presentation/pages/topic_detail_page.dart';
import 'package:flutter/widgets.dart';

Widget buildDynamicRoutePage() => const DynamicPage();

Widget buildDynamicDetailRoutePage(String id) => DynamicDetailPage(dynamicId: id);

Widget buildTopicDetailRoutePage({
  required int topicId,
  required String topicName,
}) => TopicDetailPage(topicId: topicId, topicName: topicName);

Widget buildPublishDynamicRoutePage() => const PublishDynamicPage();
