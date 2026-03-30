import 'package:culcul/features/dynamic/presentation/dynamic_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/dynamic_page.dart';
import 'package:culcul/features/dynamic/presentation/publish_dynamic_page.dart';
import 'package:flutter/widgets.dart';

Widget buildDynamicRoutePage() => const DynamicPage();

Widget buildDynamicDetailRoutePage(String id) => DynamicDetailPage(dynamicId: id);

Widget buildPublishDynamicRoutePage() => const PublishDynamicPage();
