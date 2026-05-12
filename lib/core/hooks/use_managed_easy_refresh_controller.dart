import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

EasyRefreshController useManagedEasyRefreshController() {
  final controller = useMemoized(EasyRefreshController.new, const []);

  useEffect(() {
    return controller.dispose;
  }, [controller]);

  return controller;
}
