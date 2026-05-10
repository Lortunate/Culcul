import 'package:culcul/core/contracts/search_port.dart';
import 'package:culcul/core/contracts/search_service_contract.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides feature-neutral search access for cross-feature use.
final searchPortProvider = Provider<SearchPort>((ref) {
  throw UnimplementedError('searchPortProvider must be overridden at bootstrap');
});

/// Provides search service. Must be overridden at bootstrap.
final searchServiceProvider = Provider<SearchService>((ref) {
  throw UnimplementedError('searchServiceProvider must be overridden at bootstrap');
});
