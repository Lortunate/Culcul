import 'package:culcul/features/dynamic/application/models/emote_catalog.dart';
import 'package:culcul/features/dynamic/data/emote_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_view_model.g.dart';

@riverpod
Future<List<EmotePackageViewData>> emotePackages(Ref ref) async {
  final response = await ref.watch(emoteRepositoryProvider).getUserEmotes();
  final packages = response.dataOrNull?.packages;
  if (packages == null) {
    return const <EmotePackageViewData>[];
  }

  return [
    for (final package in packages)
      EmotePackageViewData(
        id: package.id,
        text: package.text,
        url: package.url,
        emotes: [
          for (final emote in package.emote)
            EmoteViewData(id: emote.id, text: emote.text, url: emote.url),
        ],
      ),
  ];
}
