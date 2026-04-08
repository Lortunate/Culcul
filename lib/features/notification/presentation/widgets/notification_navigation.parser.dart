part of 'notification_navigation.dart';

class NotificationNavigationParser {
  const NotificationNavigationParser();

  static final RegExp _bvRegex = RegExp(r'BV[0-9A-Za-z]+', caseSensitive: false);
  static final RegExp _avRegex = RegExp(r'(?<![A-Za-z0-9])av(\d+)', caseSensitive: false);
  static final RegExp _digitRegex = RegExp(r'^\d+$');

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
      final videoId = _extractVideoId(candidate);
      if (videoId != null) {
        return NotificationNavigationTarget.video(videoId);
      }

      final dynamicId = _extractDynamicId(candidate);
      if (dynamicId != null) {
        return NotificationNavigationTarget.dynamic(dynamicId);
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

  String? _extractVideoId(String raw) {
    final bvMatch = _bvRegex.firstMatch(raw);
    if (bvMatch != null) {
      final value = bvMatch.group(0)!;
      return 'BV${value.substring(2)}';
    }

    final avMatch = _avRegex.firstMatch(raw);
    if (avMatch != null) {
      return 'av${avMatch.group(1)!}';
    }

    final parsed = Uri.tryParse(raw);
    if (parsed == null) return null;

    final queryBvid = parsed.queryParameters['bvid'];
    if (_hasText(queryBvid)) return queryBvid!.trim();

    final queryAid = _extractDigits(parsed.queryParameters['aid']);
    if (queryAid != null) return 'av$queryAid';

    for (final segment in parsed.pathSegments) {
      final segmentBv = _bvRegex.firstMatch(segment);
      if (segmentBv != null) {
        final value = segmentBv.group(0)!;
        return 'BV${value.substring(2)}';
      }
      final segmentAv = _avRegex.firstMatch(segment);
      if (segmentAv != null) return 'av${segmentAv.group(1)!}';
    }

    return null;
  }

  String? _extractDynamicId(String raw) {
    final parsed = Uri.tryParse(raw);
    if (parsed != null) {
      final queryDynamicId = _extractDigits(
        parsed.queryParameters['dynamic_id'] ??
            parsed.queryParameters['opus_id'] ??
            parsed.queryParameters['id'],
      );
      if (queryDynamicId != null) return queryDynamicId;

      final segments = parsed.pathSegments.where(_hasText).toList();
      final host = parsed.host.toLowerCase();

      if (host == 'opus' &&
          segments.length >= 2 &&
          segments.first == 'detail' &&
          _digitRegex.hasMatch(segments[1])) {
        return segments[1];
      }

      if (host.contains('t.bilibili.com')) {
        for (final segment in segments) {
          if (_digitRegex.hasMatch(segment)) return segment;
        }
      }

      for (var i = 0; i < segments.length - 1; i++) {
        final current = segments[i].toLowerCase();
        if ((current == 'opus' || current == 'dynamic' || current == 'detail') &&
            _digitRegex.hasMatch(segments[i + 1])) {
          return segments[i + 1];
        }
      }
    }

    final opusMatch = RegExp(r'/opus/(\d+)').firstMatch(raw);
    if (opusMatch != null) return opusMatch.group(1);

    final dynamicMatch = RegExp(r'/dynamic/(\d+)').firstMatch(raw);
    if (dynamicMatch != null) return dynamicMatch.group(1);

    final tMatch = RegExp(r't\.bilibili\.com/(\d+)').firstMatch(raw);
    if (tMatch != null) return tMatch.group(1);

    return null;
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

  static bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

  static String? _extractDigits(String? value) {
    if (!_hasText(value)) return null;
    final trimmed = value!.trim();
    return _digitRegex.hasMatch(trimmed) ? trimmed : null;
  }
}
