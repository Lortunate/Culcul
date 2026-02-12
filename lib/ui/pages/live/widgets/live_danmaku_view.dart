import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class LiveDanmakuView extends StatelessWidget {
  final List<LiveDanmakuItem> history;
  final ScrollController? controller;

  const LiveDanmakuView({super.key, required this.history, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      reverse: true,
      itemCount: history.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: _buildItem(context, history[index]),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, LiveDanmakuItem item) {
    if (item.dmType == 3) {
      return _buildSystemNotice(context, item);
    }

    if (item.nickname == t.live.danmaku.system_notice || item.nickname == '系统消息') {
      return _buildSystemNotice(context, item);
    }

    if (item.dmType == 1) {
      return _buildInteractMessage(item);
    }

    if (item.dmType == 2) {
      return _buildGiftMessage(context, item);
    }

    return _buildNormalMessage(context, item);
  }

  Widget _buildSystemNotice(BuildContext context, LiveDanmakuItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withOpacity(0.9), // Darker bg
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.live.danmaku.system_notice_colon,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractMessage(LiveDanmakuItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: item.nickname,
              style: const TextStyle(
                color: Color(0xFFFFB74D), // Orange for username
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: ' ${item.text}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftMessage(BuildContext context, LiveDanmakuItem item) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: item.nickname,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  TextSpan(
                    text: ' ${item.text}',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalMessage(BuildContext context, LiveDanmakuItem item) {
    final theme = Theme.of(context);
    final spans = <InlineSpan>[];

    if (item.guardLevel > 0) {
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: _buildGuardBadge(item.guardLevel),
        ),
      ));
    }

    if (item.medal.length >= 2) {
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: _buildMedalBadge(context, item.medal),
        ),
      ));
    }

    if (item.isadmin == 1) {
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: _buildAdminBadge(),
        ),
      ));
    }

    spans.add(
      TextSpan(
        text: '${item.nickname}：',
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );

    spans.add(
      TextSpan(
        text: item.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(children: spans),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildGuardBadge(int level) {
    final color = level == 1
        ? const Color(0xFFD32F2F) // Material Red 700
        : level == 2
            ? const Color(0xFF7B1FA2) // Material Purple 700
            : const Color(0xFF1976D2); // Material Blue 700

    final icon = level == 1
        ? Icons.local_police
        : level == 2
            ? Icons.star
            : Icons.shield;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        icon,
        size: 10,
        color: color,
      ),
    );
  }

  Widget _buildMedalBadge(BuildContext context, List<dynamic> medal) {
    final name = medal[1].toString();
    final level = medal[0].toString();
    int colorInt = 0;
    if (medal.length > 4 && medal[4] is int) {
      colorInt = medal[4] as int;
    }

    final color = colorInt != 0
        ? Color(0xFF000000 + colorInt)
        : Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 0.8),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
            ),
            child: Text(
              level,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0.5),
      decoration: BoxDecoration(
        color: const Color(0xFFFF5252),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        t.live.danmaku.admin,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),
      ),
    );
  }
}
