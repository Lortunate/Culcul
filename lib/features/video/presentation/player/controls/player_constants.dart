import 'package:culcul/features/video/data/dtos/play_url_dto.dart';
import 'package:culcul/i18n/strings.g.dart';

String getQualityLabel(int? quality, Translations t) {
  return switch (quality) {
    127 => t.video.quality.p8k,
    126 => t.video.quality.p_dolby,
    125 => t.video.quality.p_hdr,
    120 => t.video.quality.p4k,
    116 => t.video.quality.p1080_60,
    112 => t.video.quality.p1080_high,
    80 => t.video.quality.p1080,
    74 => t.video.quality.p720_60,
    64 => t.video.quality.p720,
    32 => t.video.quality.p480,
    16 => t.video.quality.p360,
    _ => t.video.quality.unknown,
  };
}

const List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0];

String formatPlaybackSpeedLabel(double speed) {
  final scaled = (speed * 100).round();
  final fractionDigits = scaled % 10 == 0 ? 1 : 2;
  return '${speed.toStringAsFixed(fractionDigits)}x';
}

String? getPlaybackSpeedDescription(double speed, Translations t) {
  if (speed == 1.0) {
    return t.video.player.speed_default;
  }
  return null;
}

Map<int, String> buildQualityLabels(PlayUrl? playUrl, Translations t) {
  final qualityLabels = <int, String>{};
  if (playUrl == null) {
    return qualityLabels;
  }

  final qualities = playUrl.acceptQuality;
  final descriptions = playUrl.acceptDescription;

  for (var i = 0; i < qualities.length; i++) {
    final quality = qualities[i];
    final description = i < descriptions.length ? descriptions[i].trim() : '';
    qualityLabels[quality] = description.isNotEmpty
        ? description
        : getQualityLabel(quality, t);
  }

  return qualityLabels;
}

const double kVolumeSensitivity = 2.0;
const double kBrightnessSensitivity = 200.0;
const double kSeekSensitivity = 5.0;
