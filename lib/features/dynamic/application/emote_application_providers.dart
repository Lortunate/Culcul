import 'package:culcul/features/dynamic/application/emote_port.dart';
import 'package:culcul/features/dynamic/data/emote_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_application_providers.g.dart';

@riverpod
EmotePort emotePort(Ref ref) {
  return ref.watch(emoteRepositoryProvider);
}
