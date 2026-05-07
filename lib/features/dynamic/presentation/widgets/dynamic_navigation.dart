import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/dynamic/presentation/pages/article_detail_page.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicNavigation {
  static final _bvidRegex = RegExp(r'BV[0-9A-Za-z]+');
  static final _aidRegex = RegExp(r'av(\d+)', caseSensitive: false);
  static final _dynamicIdRegex = RegExp(r'/dynamic/(\d+)');
  static final _opusIdRegex = RegExp(r'/opus/(\d+)');
  static final _tHostRegex = RegExp(r'^\d+$');
  static final _articleCvRegex = RegExp(r'^/read/cv\d+');
  static final _articleOpusRegex = RegExp(r'^/opus/\d+');
  static final _schemeRegex = RegExp(r'https?://');
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
    String? title,
    String? fallbackBvid,
    String? fallbackAid,
  }) {
    final raw = (url ?? '').trim();
    final source = raw.isNotEmpty ? raw : '${fallbackBvid ?? ''} ${fallbackAid ?? ''}';

    final bvidMatch = _bvidRegex.firstMatch(source);
    if (bvidMatch != null) {
      VideoDetailRoute(bvid: bvidMatch.group(0)!).push(context);
      return true;
    }

    if (fallbackBvid != null && fallbackBvid.isNotEmpty) {
      VideoDetailRoute(bvid: fallbackBvid).push(context);
      return true;
    }

    final uri = _normalizeUri(url);
    if (uri == null) return false;

    if (_isArticleUri(uri)) {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => ArticleDetailPage(url: uri.toString(), title: title),
        ),
      );
      return true;
    }

    final aidSource = fallbackAid != null && fallbackAid.isNotEmpty
        ? 'av$fallbackAid'
        : source;
    final aidMatch = _aidRegex.firstMatch(aidSource);
    if (aidMatch != null) {
      VideoDetailRoute(bvid: 'av${aidMatch.group(1)!}').push(context);
      return true;
    }

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
    final dynamicMatch = _dynamicIdRegex.firstMatch(uri.path);
    final opusMatch = _opusIdRegex.firstMatch(uri.path);
    final tHostMatch = host.contains('t.bilibili.com') && segments.isNotEmpty
        ? _tHostRegex.firstMatch(segments.first)
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

  static bool _isArticleUri(Uri uri) {
    final host = uri.host.toLowerCase();
    if (!host.contains('bilibili.com')) return false;

    final path = uri.path.toLowerCase();
    return _articleCvRegex.hasMatch(path) || _articleOpusRegex.hasMatch(path);
  }

  static Uri? _normalizeUri(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    var normalized = raw.trim();
    if (normalized.startsWith('//')) {
      normalized = 'https:$normalized';
    } else if (normalized.startsWith('/')) {
      normalized = 'https://www.bilibili.com$normalized';
    } else if (!_schemeRegex.hasMatch(normalized)) {
      normalized = 'https://$normalized';
    }
    return Uri.tryParse(normalized);
  }
}
