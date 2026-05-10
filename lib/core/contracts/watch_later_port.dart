abstract interface class WatchLaterPort {
  Future<void> addToWatchLater(int aid);
  Future<void> removeFromWatchLater(int aid);
}
