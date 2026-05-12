import 'dart:async';

class Semaphore {
  final int maxCount;
  int _current = 0;
  final _waiters = <Completer<void>>[];

  Semaphore(this.maxCount);

  Future<void> acquire() async {
    if (_current < maxCount) {
      _current++;
      return;
    }
    final completer = Completer<void>();
    _waiters.add(completer);
    await completer.future;
    _current++;
  }

  void release() {
    _current--;
    if (_waiters.isNotEmpty) {
      _waiters.removeAt(0).complete();
    }
  }
}
