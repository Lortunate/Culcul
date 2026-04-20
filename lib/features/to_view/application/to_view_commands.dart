import 'package:easy_refresh/easy_refresh.dart';

enum ToViewClearAllAction { unavailable, confirm }

ToViewClearAllAction planToViewClearAll({
  required bool isLoggedIn,
  required int itemCount,
}) {
  if (!isLoggedIn || itemCount <= 0) {
    return ToViewClearAllAction.unavailable;
  }
  return ToViewClearAllAction.confirm;
}

Future<bool> executeConfirmedToViewClearAll({
  required ToViewClearAllAction action,
  required Future<void> Function() clearAll,
}) async {
  if (action != ToViewClearAllAction.confirm) {
    return false;
  }
  await clearAll();
  return true;
}

Future<IndicatorResult> refreshToViewWorkflow<T>({
  required Future<T> Function() refresh,
}) async {
  try {
    await refresh();
    return IndicatorResult.success;
  } catch (_) {
    return IndicatorResult.fail;
  }
}
