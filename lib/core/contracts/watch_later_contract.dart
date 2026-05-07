/// Cross-feature contract for "watch later" (to-view) actions.
/// Features that need to add/remove videos from watch later list
/// should depend on this contract, not on to_view's internal providers.
abstract interface class WatchLaterActions {
  Future<void> addToWatchLater(int aid);
  Future<void> removeFromWatchLater(int aid);
}
