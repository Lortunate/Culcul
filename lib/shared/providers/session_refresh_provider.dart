import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SessionRefreshAction = Future<void> Function();

final sessionRefreshActionProvider = Provider<SessionRefreshAction>((ref) {
  throw UnimplementedError('sessionRefreshActionProvider must be overridden');
});
