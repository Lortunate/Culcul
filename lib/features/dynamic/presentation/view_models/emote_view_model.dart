import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_view_model.g.dart';

@riverpod
Future<List<EmotePackage>> emotePackages(Ref ref) async {
  final result = await ref.watch(emotePackagesWorkflowProvider).call();
  return result.when(success: (value) => value, failure: (error) => throw error);
}
