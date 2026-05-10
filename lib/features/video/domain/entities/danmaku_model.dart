class DanmakuEntry {
  final String content;
  final int progress;
  final int color;
  final int mode;

  const DanmakuEntry({
    required this.content,
    required this.progress,
    required this.color,
    required this.mode,
  });
}

class DanmakuSegment {
  final List<DanmakuEntry> entries;
  final int state;

  const DanmakuSegment({required this.entries, required this.state});
}

class DanmakuView {
  final bool closed;
  final bool allow;
  final int sendBoxStyle;
  final String textPlaceholder;
  final String inputPlaceholder;

  const DanmakuView({
    required this.closed,
    required this.allow,
    required this.sendBoxStyle,
    required this.textPlaceholder,
    required this.inputPlaceholder,
  });
}
