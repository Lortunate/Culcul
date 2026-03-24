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
  DanmakuOption option = DanmakuOption();

  void pause() {
    onPause.call();
  }

  void resume() {
    onResume.call();
  }

  void clear() {
    onClear.call();
  }

  void addItems(List<DanmakuItem> items) {
    onAddItems.call(items);
  }

  void updateOption(DanmakuOption option) {
    onUpdateOption.call(option);
  }
}
