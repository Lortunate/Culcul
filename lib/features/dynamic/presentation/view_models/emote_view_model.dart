import 'package:culcul/features/dynamic/application/models/emote_response.dart';
import 'package:culcul/features/dynamic/data/emote_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_view_model.g.dart';

@riverpod
Future<List<EmotePackage>> emotePackages(Ref ref) async {
  final response = await ref.watch(emoteRepositoryProvider).getUserEmotes();
  return response.dataOrNull?.packages ?? const <EmotePackage>[];
}
