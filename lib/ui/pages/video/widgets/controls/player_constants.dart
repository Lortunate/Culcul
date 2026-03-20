const Map<int, String> qualityLabels = {
  127: '8K 超高清',
  126: '杜比视界',
  125: 'HDR 真彩',
  120: '4K 超清',
  116: '1080P 60帧',
  112: '1080P 高码率',
  80: '1080P 高清',
  74: '720P 60帧',
  64: '720P 高清',
  32: '480P 清晰',
  16: '360P 流畅',
};

const List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

const Map<int, String> qualityDescriptions = {
  127: '8K 超高清 (7680p)',
  126: '杜比视界 (Dolby Vision)',
  125: 'HDR 真彩 (High Dynamic Range)',
  120: '4K 超清 (2160p)',
  116: '1080P 60帧',
  112: '1080P 高码率',
  80: '1080P 高清',
  74: '720P 60帧',
  64: '720P 高清',
  32: '480P 清晰',
  16: '360P 流畅',
};

const double kVolumeSensitivity = 2.0;
const double kBrightnessSensitivity = 200.0;
const double kSeekSensitivity = 5.0;
