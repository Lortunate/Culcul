import 'dart:async';
import 'dart:ui';

import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';

part 'interaction_layer.gestures.dart';

const double _brightnessStep = 0.01;
const double _volumeStep = 1.0;

enum _DragMode { idle, horizontal, vertical }

class InteractionLayer extends HookConsumerWidget {
  final Widget child;
  final String bvid;
  final ValueNotifier<double> brightness;
  final double currentVolume;

  const InteractionLayer({
    super.key,
    required this.child,
    required this.bvid,
    required this.brightness,
    required this.currentVolume,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _InteractionGestureSurface(
      bvid: bvid,
      brightness: brightness,
      currentVolume: currentVolume,
      child: child,
    );
  }
}

class _DragSession {
  double horizontalDelta = 0.0;
  double verticalDelta = 0.0;
  double verticalStartVolume = 0.0;
  double verticalStartBrightness = 0.0;
  double lastAppliedVolume = 0.0;
  double lastAppliedBrightness = 0.0;
  int lastVerticalUpdateMs = 0;

  void startHorizontal() {
    horizontalDelta = 0.0;
  }

  void startVertical({required double currentBrightness, required double currentVolume}) {
    verticalDelta = 0.0;
    verticalStartBrightness = currentBrightness;
    verticalStartVolume = currentVolume;
    lastAppliedBrightness = currentBrightness;
    lastAppliedVolume = currentVolume;
    lastVerticalUpdateMs = 0;
  }

  void reset({required double currentBrightness, required double currentVolume}) {
    horizontalDelta = 0.0;
    verticalDelta = 0.0;
    verticalStartBrightness = currentBrightness;
    verticalStartVolume = currentVolume;
    lastAppliedBrightness = currentBrightness;
    lastAppliedVolume = currentVolume;
    lastVerticalUpdateMs = 0;
  }
}
