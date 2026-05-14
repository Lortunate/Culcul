import 'package:culcul/core/contracts/watch_later_port.dart';
import 'package:culcul/features/to_view/application/watch_later_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch_later_port_provider.g.dart';

@Riverpod(keepAlive: true)
WatchLaterPort watchLaterPort(Ref ref) {
  return WatchLaterAdapter(ref);
}
