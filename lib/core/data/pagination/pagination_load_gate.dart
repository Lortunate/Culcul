import 'package:easy_refresh/easy_refresh.dart';

class PaginationLoadGate {
  bool _inFlight = false;

  void reset() {
    _inFlight = false;
  }

  Future<IndicatorResult> run({
    required bool hasMoreBefore,
    required Future<void> Function() task,
    bool Function()? hasMoreAfter,
  }) async {
    if (!hasMoreBefore) {
      return IndicatorResult.noMore;
    }
    if (_inFlight) {
      return IndicatorResult.success;
    }

    _inFlight = true;
    try {
      await task();
      final hasMore = hasMoreAfter?.call();
      return hasMore == false ? IndicatorResult.noMore : IndicatorResult.success;
    } catch (_) {
      return IndicatorResult.fail;
    } finally {
      _inFlight = false;
    }
  }
}
