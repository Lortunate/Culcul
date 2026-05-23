import 'package:culcul/features/dynamic/application/emote_application_providers.dart';
import 'package:culcul/features/dynamic/application/models/emote_catalog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_view_model.g.dart';

@riverpod
Future<List<EmoteCatalogPackage>> emotePackages(Ref ref) async {
  final response = await ref.watch(emotePortProvider).getUserEmotePackages();
  return response.dataOrNull ?? const <EmoteCatalogPackage>[];
}
