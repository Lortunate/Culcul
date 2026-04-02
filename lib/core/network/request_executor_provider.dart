import 'package:culcul/core/network/request_executor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final requestExecutorProvider = Provider<RequestExecutor>((ref) {
  return const RequestExecutor();
});
