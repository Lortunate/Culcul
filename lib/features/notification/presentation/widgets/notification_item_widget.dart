import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_navigation.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:culcul/core/utils/format_extensions.dart';

part 'notification_item_widget.content.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationEntry item;
  final NotificationFeedType type;
  static const NotificationNavigationParser _navigationParser =
      NotificationNavigationParser();

  const NotificationItemWidget({super.key, required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    return _NotificationItemContent(
      item: item,
      type: type,
      navigationParser: _navigationParser,
    );
  }
}
