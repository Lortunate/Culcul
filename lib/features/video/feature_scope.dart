import 'package:culcul/features/video/application/video_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/video/application/video_facade.dart' show videoFacadeProvider;

final videoFacadeEntryProvider = Provider<VideoFacade>(
  (ref) => ref.watch(videoFacadeProvider),
);
