import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides relation repository access for cross-feature use.
/// Must be overridden at bootstrap.
final crossRelationRepositoryProvider = Provider<dynamic>((ref) {
  throw UnimplementedError('crossRelationRepositoryProvider must be overridden at bootstrap');
});
