import 'models/danmaku_option.dart';

import 'models/danmaku_item.dart';

class DanmakuController {
  final void Function(List<DanmakuItem>) onAddItems;
  final void Function(DanmakuOption) onUpdateOption;
  final void Function() onPause;
  final void Function() onResume;
  final void Function() onClear;
  DanmakuController({
    required this.onAddItems,
    required this.onUpdateOption,
    required this.onPause,
    required this.onResume,
    required this.onClear,
  });

  bool running = true;

  /// 是否运行中
  /// 可以调用pause()暂停弹幕
  DanmakuOption option = DanmakuOption();

  /// 暂停弹幕
  void pause() {
    onPause.call();
  }

  /// 继续弹幕
  void resume() {
    onResume.call();
  }

  /// 清空弹幕
  void clear() {
    onClear.call();
  }

  /// 添加弹幕
  void addItems(List<DanmakuItem> item) {
    onAddItems.call(item);
  }

  void updateOption(DanmakuOption option) {
    onUpdateOption.call(option);
  }
}
