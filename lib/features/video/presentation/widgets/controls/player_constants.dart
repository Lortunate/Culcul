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

const List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

const double kVolumeSensitivity = 2.0;
const double kBrightnessSensitivity = 200.0;
const double kSeekSensitivity = 5.0;
