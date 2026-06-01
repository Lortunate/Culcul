import 'dart:collection';

final class DanmakuEntry {
  const DanmakuEntry({
    required this.content,
    required this.progress,
    required this.color,
    required this.mode,
  });

  final String content;
  final int progress;
  final int color;
  final int mode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is DanmakuEntry &&
            other.content == content &&
            other.progress == progress &&
            other.color == color &&
            other.mode == mode;
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, progress, color, mode);

  @override
  String toString() {
    return 'DanmakuEntry(content: $content, progress: $progress, '
        'color: $color, mode: $mode)';
  }
}

final class DanmakuSegment {
  DanmakuSegment({required List<DanmakuEntry> entries, required this.state})
    : _entries = List<DanmakuEntry>.unmodifiable(entries);

  final List<DanmakuEntry> _entries;
  final int state;

  List<DanmakuEntry> get entries => UnmodifiableListView(_entries);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is DanmakuSegment &&
            other.state == state &&
            other._entries.length == _entries.length &&
            other._entries.asMap().entries.every(
              (entry) => entry.value == _entries[entry.key],
            );
  }

  @override
  int get hashCode => Object.hash(runtimeType, Object.hashAll(_entries), state);

  @override
  String toString() => 'DanmakuSegment(entries: $entries, state: $state)';
}
