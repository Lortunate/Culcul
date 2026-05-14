import 'package:culcul/core/contracts/watch_later_port.dart';
import 'package:culcul/features/to_view/application/watch_later_adapter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final watchLaterPortProvider = Provider<WatchLaterPort>((ref) {
  return WatchLaterAdapter(ref);
});
