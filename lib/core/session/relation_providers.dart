import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ModifyRelation =
    Future<Result<void, AppError>> Function({required int mid, required bool isFollow});

/// Provides relation repository access for cross-feature use.
final crossRelationRepositoryProvider = Provider<RelationRepository>((ref) {
  throw UnimplementedError(
    'crossRelationRepositoryProvider must be overridden at bootstrap',
  );
});

/// Modifies follow relation. Must be overridden at bootstrap.
final modifyRelationProvider = Provider<ModifyRelation>((ref) {
  throw UnimplementedError('modifyRelationProvider must be overridden at bootstrap');
});
