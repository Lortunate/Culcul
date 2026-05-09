import 'package:culcul/core/contracts/search_service_contract.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides search service. Must be overridden at bootstrap.
final searchServiceProvider = Provider<SearchService>((ref) {
  throw UnimplementedError('searchServiceProvider must be overridden at bootstrap');
});
