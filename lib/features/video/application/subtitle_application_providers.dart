import 'package:culcul/features/video/application/subtitle_port.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subtitle_application_providers.g.dart';

@riverpod
SubtitlePort subtitlePort(Ref ref) {
  return ref.watch(videoRepositoryProvider);
}
