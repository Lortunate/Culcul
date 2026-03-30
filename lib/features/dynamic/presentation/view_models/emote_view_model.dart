import 'package:culcul/features/dynamic/domain/entities/dynamic_models.dart';
import 'package:culcul/features/dynamic/application/use_case/dynamic_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emote_view_model.g.dart';

@riverpod
Future<List<EmotePackage>> emotePackages(Ref ref) async {
  final result = await ref.watch(emotePackagesUseCaseProvider).call();
  return result.when(success: (value) => value, failure: (error) => throw error);
}
