import 'package:culcul/data/models/emote/emote_response.dart';
import 'package:culcul/features/dynamic/data/emote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_provider.g.dart';

@riverpod
Future<List<EmotePackage>> emotePackages(Ref ref) async {
  final result = await ref.watch(emoteRepositoryProvider).getUserEmotes();
  return result.when(success: (data) => data.packages, failure: (e) => throw e);
}

