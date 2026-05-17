import 'package:culcul/core/contracts/watch_later_port.dart';
import 'package:culcul/features/to_view/application/to_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Bridges core's WatchLaterPort contract with to_view's controller.
class WatchLaterAdapter implements WatchLaterPort {
  final Ref _ref;
  WatchLaterAdapter(this._ref);

  @override
  Future<void> addToWatchLater(int aid) async {
    await _ref.read(toViewListProvider.notifier).add(aid);
  }

  @override
  Future<void> removeFromWatchLater(int aid) async {
    await _ref.read(toViewListProvider.notifier).delete(aid);
  }
}
