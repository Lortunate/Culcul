part of 'notification_navigation.dart';

class NotificationNavigationParser {
  const NotificationNavigationParser();

  static const _linkParser = BilibiliLinkParser();

  NotificationNavigationTarget fromNotificationDetail(NotificationEntryDetail detail) {
    return parse(
      uri: detail.uri,
      nativeUri: detail.nativeUri,
      type: detail.type,
      business: detail.business,
      subjectId: detail.subjectId,
    );
  }

  NotificationNavigationTarget fromSystemNotice(SystemNotice notice) {
    return parse(uri: notice.uri);
  }

  NotificationNavigationTarget parse({
    String? uri,
    String? nativeUri,
    String? type,
    String? business,
    int? subjectId,
  }) {
    final normalizedType = (type ?? '').toLowerCase();
    final normalizedBusiness = (business ?? '').toLowerCase();
    final candidates = <String>[
      if (_hasText(nativeUri)) nativeUri!.trim(),
      if (_hasText(uri)) uri!.trim(),
    ];

    for (final candidate in candidates) {
      final target = _linkParser.parse(candidate);
      switch (target.kind) {
        case BilibiliLinkKind.video:
          return NotificationNavigationTarget.video(target.videoId!);
        case BilibiliLinkKind.dynamicDetail:
          return NotificationNavigationTarget.dynamic(target.dynamicId!);
        case BilibiliLinkKind.article:
          final opusId = _extractOpusId(target.uri!);
          if (opusId != null) return NotificationNavigationTarget.dynamic(opusId);
          continue;
        case BilibiliLinkKind.liveRoom:
        case BilibiliLinkKind.external:
        case BilibiliLinkKind.none:
          continue;
      }
    }

    if ((normalizedBusiness == 'archive' || normalizedType == 'video') &&
        subjectId != null &&
        subjectId > 0) {
      return NotificationNavigationTarget.video('av$subjectId');
    }

    if ((normalizedBusiness == 'dynamic' ||
            normalizedType == 'dynamic' ||
            normalizedType == 'opus') &&
        subjectId != null &&
        subjectId > 0) {
      return NotificationNavigationTarget.dynamic(subjectId.toString());
    }

    for (final candidate in candidates) {
      final externalUri = _tryExternalUri(candidate);
      if (externalUri != null) {
        return NotificationNavigationTarget.external(externalUri);
      }
    }

    return const NotificationNavigationTarget.none();
  }

  Uri? _tryExternalUri(String raw) {
    final parsed = Uri.tryParse(raw);
    if (parsed == null || parsed.scheme.isEmpty) return null;
    final scheme = parsed.scheme.toLowerCase();
    if (scheme == 'http' || scheme == 'https' || scheme == 'bilibili') {
      return parsed;
    }
    return null;
  }

  String? _extractOpusId(Uri uri) {
    final segments = uri.pathSegments;
    if (segments.length >= 2 && segments.first.toLowerCase() == 'opus') {
      return segments[1];
    }
    return null;
  }

  static bool _hasText(String? value) => value != null && value.trim().isNotEmpty;
}
