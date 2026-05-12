import 'package:culcul/features/video/domain/entities/video_entities.dart' as domain;

List<String> buildPlayableUrlsFromDurl(domain.Durl durl) {
  final seen = <String>{};
  final candidates = <String>[];
  for (final raw in <String>[durl.url, ...durl.backupUrl]) {
    final normalized = normalizeMediaUrl(raw);
    if (normalized == null) {
      continue;
    }
    if (seen.add(normalized)) {
      candidates.add(normalized);
    }
  }
  return candidates;
}

List<String> buildAudioPlayableUrlsFromDash(domain.DashInfo? dash) {
  if (dash == null || dash.audio.isEmpty) {
    return const [];
  }

  final seen = <String>{};
  final candidates = <String>[];
  final sortedAudio = [...dash.audio]..sort((a, b) => b.bandwidth.compareTo(a.bandwidth));

  for (final stream in sortedAudio) {
    for (final raw in <String>[stream.baseUrl, ...stream.backupUrl]) {
      final normalized = normalizeMediaUrl(raw);
      if (normalized == null) {
        continue;
      }
      if (seen.add(normalized)) {
        candidates.add(normalized);
      }
    }
  }

  return candidates;
}

List<String> buildListenAudioCandidateUrls({
  domain.DashInfo? dash,
  domain.Durl? fallbackDurl,
}) {
  final dashCandidates = buildAudioPlayableUrlsFromDash(dash);
  if (dashCandidates.isNotEmpty) {
    return dashCandidates;
  }

  if (fallbackDurl == null) {
    return const [];
  }

  return buildPlayableUrlsFromDurl(fallbackDurl);
}

List<String> buildFallbackVideoUrlsFromPlayUrl(domain.PlayUrl? playUrl) {
  if (playUrl == null || playUrl.durl.isEmpty) {
    return const [];
  }
  return buildPlayableUrlsFromDurl(playUrl.durl.first);
}

String? normalizeMediaUrl(String raw) {
  final value = raw.trim();
  if (value.isEmpty) {
    return null;
  }
  final withScheme = value.startsWith('//') ? 'https:$value' : value;
  final uri = Uri.tryParse(withScheme);
  if (uri == null) {
    return withScheme;
  }

  final host = uri.host.toLowerCase();
  final isBiliVideoHost =
      host.endsWith('.bilivideo.com') ||
      host.endsWith('.bilivideo.cn') ||
      host.endsWith('.akamaized.net');
  if (uri.scheme == 'http' && isBiliVideoHost) {
    return uri.replace(scheme: 'https').toString();
  }

  return withScheme;
}
