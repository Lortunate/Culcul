enum BilibiliLinkKind { video, dynamicDetail, article, liveRoom, external, none }

class BilibiliLinkTarget {
  const BilibiliLinkTarget._({
    required this.kind,
    this.videoId,
    this.dynamicId,
    this.liveRoomId,
    this.uri,
  });

  const BilibiliLinkTarget.video(String videoId)
    : this._(kind: BilibiliLinkKind.video, videoId: videoId);

  const BilibiliLinkTarget.dynamic(String dynamicId)
    : this._(kind: BilibiliLinkKind.dynamicDetail, dynamicId: dynamicId);

  const BilibiliLinkTarget.article(Uri uri)
    : this._(kind: BilibiliLinkKind.article, uri: uri);

  const BilibiliLinkTarget.liveRoom(int roomId)
    : this._(kind: BilibiliLinkKind.liveRoom, liveRoomId: roomId);

  const BilibiliLinkTarget.external(Uri uri)
    : this._(kind: BilibiliLinkKind.external, uri: uri);

  const BilibiliLinkTarget.none() : this._(kind: BilibiliLinkKind.none);

  final BilibiliLinkKind kind;
  final String? videoId;
  final String? dynamicId;
  final int? liveRoomId;
  final Uri? uri;
}

class BilibiliLinkParser {
  const BilibiliLinkParser();

  static final RegExp _bvidRegex = RegExp(r'BV[0-9A-Za-z]+', caseSensitive: false);
  static final RegExp _aidRegex = RegExp(
    r'(?<![A-Za-z0-9])av(\d+)',
    caseSensitive: false,
  );
  static final RegExp _digitRegex = RegExp(r'^\d+$');
  static final RegExp _schemeRegex = RegExp(r'^[a-z][a-z0-9+.-]*://');
  static final RegExp _opusPathRegex = RegExp(r'/opus/(\d+)');
  static final RegExp _dynamicPathRegex = RegExp(r'/dynamic/(\d+)');
  static final RegExp _tHostPathRegex = RegExp(r't\.bilibili\.com/(\d+)');
  static final RegExp _articleCvRegex = RegExp(r'^/read/cv\d+');
  static final RegExp _articleOpusRegex = RegExp(r'^/opus/\d+');

  BilibiliLinkTarget parse(String? raw, {String? fallbackBvid, String? fallbackAid}) {
    final normalizedRaw = _textOrNull(raw);
    final normalizedFallbackBvid = _textOrNull(fallbackBvid);
    final normalizedFallbackAid = _extractDigits(fallbackAid);
    final fallbackAidSource = normalizedFallbackAid == null
        ? null
        : 'av$normalizedFallbackAid';
    final source = [
      ?normalizedRaw,
      ?normalizedFallbackBvid,
      ?fallbackAidSource,
    ].join(' ');

    final bvid = _extractBvid(source);
    if (bvid != null) return BilibiliLinkTarget.video(bvid);

    if (normalizedFallbackBvid != null) {
      return BilibiliLinkTarget.video(normalizedFallbackBvid);
    }

    final uri = normalizeUri(raw);
    if (uri != null) {
      if (_isArticleUri(uri)) return BilibiliLinkTarget.article(uri);

      final liveRoomId = _extractLiveRoomId(uri);
      if (liveRoomId != null) return BilibiliLinkTarget.liveRoom(liveRoomId);

      final dynamicId = _extractDynamicId(normalizedRaw!, uri);
      if (dynamicId != null) return BilibiliLinkTarget.dynamic(dynamicId);

      final uriVideoId = _extractVideoIdFromUri(uri);
      if (uriVideoId != null) return BilibiliLinkTarget.video(uriVideoId);
    }

    final aid = _extractAid(source);
    if (aid != null) return BilibiliLinkTarget.video(aid);

    if (uri != null && _isExternalUri(uri)) {
      return BilibiliLinkTarget.external(uri);
    }

    return const BilibiliLinkTarget.none();
  }

  Uri? normalizeUri(String? raw) {
    final text = _textOrNull(raw);
    if (text == null) return null;

    var normalized = text;
    if (normalized.startsWith('//')) {
      normalized = 'https:$normalized';
    } else if (normalized.startsWith('/')) {
      normalized = 'https://www.bilibili.com$normalized';
    } else if (!_schemeRegex.hasMatch(normalized)) {
      normalized = 'https://$normalized';
    }
    return Uri.tryParse(normalized);
  }

  static bool _isArticleUri(Uri uri) {
    final host = uri.host.toLowerCase();
    if (!host.contains('bilibili.com')) return false;

    final path = uri.path.toLowerCase();
    return _articleCvRegex.hasMatch(path) || _articleOpusRegex.hasMatch(path);
  }

  static int? _extractLiveRoomId(Uri uri) {
    final host = uri.host.toLowerCase();
    if (!host.contains('live.bilibili.com')) return null;

    final segments = uri.pathSegments.where(_hasText).toList();
    if (segments.isEmpty) return null;
    return int.tryParse(segments.first);
  }

  static String? _extractVideoIdFromUri(Uri uri) {
    final queryBvid = _textOrNull(uri.queryParameters['bvid']);
    if (queryBvid != null) return _normalizeBvid(queryBvid);

    final queryAid = _extractDigits(uri.queryParameters['aid']);
    if (queryAid != null) return 'av$queryAid';

    for (final segment in uri.pathSegments) {
      final bvid = _extractBvid(segment);
      if (bvid != null) return bvid;

      final aid = _extractAid(segment);
      if (aid != null) return aid;
    }

    return null;
  }

  static String? _extractDynamicId(String raw, Uri uri) {
    final queryDynamicId = _extractDigits(
      uri.queryParameters['dynamic_id'] ??
          uri.queryParameters['opus_id'] ??
          uri.queryParameters['id'],
    );
    if (queryDynamicId != null) return queryDynamicId;

    final segments = uri.pathSegments.where(_hasText).toList();
    final host = uri.host.toLowerCase();

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

    final opusMatch = _opusPathRegex.firstMatch(raw);
    if (opusMatch != null) return opusMatch.group(1);

    final dynamicMatch = _dynamicPathRegex.firstMatch(raw);
    if (dynamicMatch != null) return dynamicMatch.group(1);

    final tMatch = _tHostPathRegex.firstMatch(raw);
    if (tMatch != null) return tMatch.group(1);

    return null;
  }

  static bool _isExternalUri(Uri uri) {
    final scheme = uri.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https' || scheme == 'bilibili';
  }

  static String? _extractBvid(String value) {
    final match = _bvidRegex.firstMatch(value);
    return match == null ? null : _normalizeBvid(match.group(0)!);
  }

  static String _normalizeBvid(String value) => 'BV${value.trim().substring(2)}';

  static String? _extractAid(String value) {
    final match = _aidRegex.firstMatch(value);
    return match == null ? null : 'av${match.group(1)!}';
  }

  static String? _extractDigits(String? value) {
    final text = _textOrNull(value);
    return text != null && _digitRegex.hasMatch(text) ? text : null;
  }

  static String? _textOrNull(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static bool _hasText(String? value) => _textOrNull(value) != null;
}
