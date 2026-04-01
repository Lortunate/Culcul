import 'dart:async';

import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String useVideoSession(WidgetRef ref, String bvid) {
  final playerController = ref.read(playerControllerProvider.notifier);
  final sessionId = useMemoized(
    () => 'video:$bvid:${DateTime.now().microsecondsSinceEpoch}',
    [bvid],
  );

  useEffect(() {
    var disposed = false;
    unawaited(
      Future<void>(() async {
        if (disposed) {
          return;
        }
        await playerController.enterSession(sessionId);
      }),
    );
    return () {
      disposed = true;
      unawaited(Future<void>(() => playerController.leaveSession(sessionId)));
    };
  }, [playerController, sessionId]);

  return sessionId;
}
