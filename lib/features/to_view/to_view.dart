import 'package:culcul/core/contracts/watch_later_port.dart';
import 'package:culcul/features/to_view/application/watch_later_port_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

WatchLaterPort readWatchLaterPort(WidgetRef ref) {
  return ref.read(watchLaterPortProvider);
}
