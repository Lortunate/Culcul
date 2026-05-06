import 'dart:async';

import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_constants.dart';
import 'package:culcul/features/video/presentation/widgets/controls/seek_ripple_overlay.dart';
import 'package:culcul/features/video/presentation/widgets/layers/gesture_feedback_overlay.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';

part 'interaction_layer.gestures.dart';
part 'interaction_layer.drag_session.dart';
part 'interaction_layer.seek_overlay.dart';

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
