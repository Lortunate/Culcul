import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides search repository access for cross-feature use.
/// Must be overridden at bootstrap.
final crossSearchRepositoryProvider = Provider<dynamic>((ref) {
  throw UnimplementedError('crossSearchRepositoryProvider must be overridden at bootstrap');
});
