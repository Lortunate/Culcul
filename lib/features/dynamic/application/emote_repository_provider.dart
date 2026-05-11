import 'package:culcul/features/dynamic/data/emote_repository_impl.dart' as data;
import 'package:culcul/features/dynamic/domain/repositories/emote_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final emoteRepositoryProvider = data.emoteRepositoryProvider;

final emoteRepositoryEntryProvider = Provider<EmoteRepository>((ref) {
  return ref.watch(emoteRepositoryProvider);
});
