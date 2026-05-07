import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ModifyRelation = Future<Result<void, AppError>> Function({
  required int mid,
  required bool isFollow,
});

/// Modifies follow relation. Must be overridden at bootstrap.
final modifyRelationProvider = Provider<ModifyRelation>((ref) {
  throw UnimplementedError('modifyRelationProvider must be overridden at bootstrap');
});
