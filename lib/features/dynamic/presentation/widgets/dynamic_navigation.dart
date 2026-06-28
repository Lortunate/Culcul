import 'package:culcul/core/models/bilibili_link_contract.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicNavigation {
  static const _parser = BilibiliLinkParser();

  static Future<void> open(
    BuildContext context, {
    String? url,
    String? title,
    String? fallbackBvid,
    String? fallbackAid,
  }) async {
    if (_openInternal(
      context,
      url: url,
      title: title,
      fallbackBvid: fallbackBvid,
      fallbackAid: fallbackAid,
    )) {
      return;
    }

    final uri = _parser.normalizeUri(url);
    if (uri == null) return;

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      context.showAppFeedback(Translations.of(context).moments.open_link_failed);
    }
  }

  static bool _openInternal(
    BuildContext context, {
    String? url,
    String? title,
    String? fallbackBvid,
    String? fallbackAid,
  }) {
    final navigation = DynamicNavigationScope.of(context);
    final target = _parser.parse(
      url,
      fallbackBvid: fallbackBvid,
      fallbackAid: fallbackAid,
    );

    switch (target.kind) {
      case BilibiliLinkKind.video:
        navigation.onOpenVideo(target.videoId!);
        return true;
      case BilibiliLinkKind.dynamicDetail:
        navigation.onOpenDynamicDetail(target.dynamicId!);
        return true;
      case BilibiliLinkKind.article:
        navigation.onOpenArticle(target.uri!.toString(), title);
        return true;
      case BilibiliLinkKind.liveRoom:
        navigation.onOpenLiveRoom(target.liveRoomId!);
        return true;
      case BilibiliLinkKind.external:
      case BilibiliLinkKind.none:
        return false;
    }
  }
}
