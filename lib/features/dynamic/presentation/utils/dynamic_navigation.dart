import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicNavigation {
  static Future<void> open(
    BuildContext context, {
    String? url,
    String? fallbackBvid,
    String? fallbackAid,
  }) async {
    if (_openInternal(
      context,
      url: url,
      fallbackBvid: fallbackBvid,
      fallbackAid: fallbackAid,
    )) {
      return;
    }

    final uri = _normalizeUri(url);
    if (uri == null) return;

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Translations.of(context).moments.open_link_failed)),
      );
    }
  }

  static bool _openInternal(
    BuildContext context, {
    String? url,
    String? fallbackBvid,
    String? fallbackAid,
  }) {
    final raw = (url ?? '').trim();
    final source = raw.isNotEmpty ? raw : '${fallbackBvid ?? ''} ${fallbackAid ?? ''}';

    final bvidMatch = RegExp(r'BV[0-9A-Za-z]+').firstMatch(source);
    if (bvidMatch != null) {
      VideoDetailRoute(bvid: bvidMatch.group(0)!).push(context);
      return true;
    }

    if (fallbackBvid != null && fallbackBvid.isNotEmpty) {
      VideoDetailRoute(bvid: fallbackBvid).push(context);
      return true;
    }

    final aidSource = fallbackAid != null && fallbackAid.isNotEmpty
        ? 'av$fallbackAid'
        : source;
    final aidMatch = RegExp(r'av(\d+)', caseSensitive: false).firstMatch(aidSource);
    if (aidMatch != null) {
      VideoDetailRoute(bvid: 'av${aidMatch.group(1)!}').push(context);
      return true;
    }

    final uri = _normalizeUri(url);
    if (uri == null) return false;

    final host = uri.host.toLowerCase();
    final segments = uri.pathSegments.where((e) => e.isNotEmpty).toList();

    if (host.contains('live.bilibili.com') && segments.isNotEmpty) {
      final roomId = int.tryParse(segments.first);
      if (roomId != null) {
        LiveRoomRoute(roomId: roomId).push(context);
        return true;
      }
    }

    String? dynamicId;
    final dynamicMatch = RegExp(r'/dynamic/(\d+)').firstMatch(uri.path);
    final opusMatch = RegExp(r'/opus/(\d+)').firstMatch(uri.path);
    final tHostMatch = host.contains('t.bilibili.com') && segments.isNotEmpty
        ? RegExp(r'^\d+$').firstMatch(segments.first)
        : null;

    if (dynamicMatch != null) {
      dynamicId = dynamicMatch.group(1);
    } else if (opusMatch != null) {
      dynamicId = opusMatch.group(1);
    } else if (tHostMatch != null) {
      dynamicId = tHostMatch.group(0);
    }

    if (dynamicId != null && dynamicId.isNotEmpty) {
      DynamicDetailRoute(id: dynamicId).push(context);
      return true;
    }

    return false;
  }

  static Uri? _normalizeUri(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    var normalized = raw.trim();
    if (normalized.startsWith('//')) {
      normalized = 'https:$normalized';
    } else if (normalized.startsWith('/')) {
      normalized = 'https://www.bilibili.com$normalized';
    } else if (!normalized.startsWith(RegExp(r'https?://'))) {
      normalized = 'https://$normalized';
    }
    return Uri.tryParse(normalized);
  }
}

