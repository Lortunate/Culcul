import 'package:culcul/core/contracts/watch_later_contract.dart';
import 'package:culcul/features/to_view/presentation/view_models/to_view_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Bridges core's WatchLaterActions contract with to_view's view model.
class WatchLaterAdapter implements WatchLaterActions {
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
