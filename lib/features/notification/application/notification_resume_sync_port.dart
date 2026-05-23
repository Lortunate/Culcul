/// Notification app-resume synchronization application boundary.
abstract interface class NotificationResumeSyncPort {
  Future<void> syncOnResume({required int ownerUid});
}
