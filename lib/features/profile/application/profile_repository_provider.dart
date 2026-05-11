import 'package:culcul/features/profile/data/profile_repository_impl.dart' as data;
import 'package:culcul/features/profile/data/relation_repository_impl.dart' as relation_data;
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileRepositoryProvider = data.profileRepositoryProvider;
final relationRepositoryProvider = relation_data.relationRepositoryProvider;

final profileRepositoryEntryProvider = Provider<ProfileRepository>((ref) {
  return ref.watch(profileRepositoryProvider);
});

final relationRepositoryEntryProvider = Provider<RelationRepository>((ref) {
  return ref.watch(relationRepositoryProvider);
});
