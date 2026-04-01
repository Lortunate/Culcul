import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/i18n/strings.g.dart';

String formatNetworkPresetLabel(Translations t, String presetId) {
  return switch (presetId) {
    'official_direct' => t.settings.network.presets.official_direct,
    'dns_backup' => t.settings.network.presets.dns_backup,
    'app_backup' => t.settings.network.presets.app_backup,
    'app_dns_backup' => t.settings.network.presets.app_dns_backup,
    'cdn_cos' => t.settings.network.presets.cdn_cos,
    'cdn_ks3' => t.settings.network.presets.cdn_ks3,
    'cdn_ali' => t.settings.network.presets.cdn_ali,
    'cdn_hw' => t.settings.network.presets.cdn_hw,
    'cdn_bos' => t.settings.network.presets.cdn_bos,
    'cdn_tencent' => t.settings.network.presets.cdn_tencent,
    'cdn_akam' => t.settings.network.presets.cdn_akam,
    _ => presetId,
  };
}

String formatNetworkProbeTime(Translations t, DateTime? probeAt) {
  if (probeAt == null) {
    return t.settings.network.not_tested;
  }

  final hour = probeAt.hour.toString().padLeft(2, '0');
  final minute = probeAt.minute.toString().padLeft(2, '0');
  final second = probeAt.second.toString().padLeft(2, '0');
  return '$hour:$minute:$second';
}

String formatNetworkLatency(
  Translations t,
  BiliLatencySnapshot? latency, {
  bool compact = false,
}) {
  if (latency == null || latency.totalLatencyMs == null) {
    return t.settings.network.latency_unreachable;
  }

  if (compact) {
    return '${latency.totalLatencyMs}ms';
  }

  final apiLatency = latency.apiLatencyMs?.toString() ?? '--';
  final cdnLatency = latency.cdnLatencyMs?.toString() ?? '--';
  return '${latency.totalLatencyMs}ms  ·  API $apiLatency / CDN $cdnLatency';
}
