import 'package:culcul/core/contracts/search_port.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides feature-neutral search access for cross-feature use.
final searchPortProvider = Provider<SearchPort>((ref) {
  throw UnimplementedError('searchPortProvider must be overridden at bootstrap');
});
