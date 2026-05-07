import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef SessionRefreshAction = Future<void> Function();

final sessionRefreshActionProvider = Provider<SessionRefreshAction>((ref) {
  throw UnimplementedError('sessionRefreshActionProvider must be overridden');
});
