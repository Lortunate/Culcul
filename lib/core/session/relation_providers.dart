import 'package:culcul/core/contracts/relation_port.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ModifyRelation =
    Future<Result<void, AppError>> Function({required int mid, required bool isFollow});

/// Provides feature-neutral relation access for cross-feature use.
final relationPortProvider = Provider<RelationPort>((ref) {
  throw UnimplementedError('relationPortProvider must be overridden at bootstrap');
});

/// Modifies follow relation. Must be overridden at bootstrap.
final modifyRelationProvider = Provider<ModifyRelation>((ref) {
  throw UnimplementedError('modifyRelationProvider must be overridden at bootstrap');
});
