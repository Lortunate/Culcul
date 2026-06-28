final class SystemNotice {
  const SystemNotice({
    required this.id,
    this.title,
    this.text,
    required this.time,
    this.uri,
    this.jumpText,
  });

  final int id;
  final String? title;
  final String? text;
  final int time;
  final String? uri;
  final String? jumpText;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is SystemNotice &&
            other.id == id &&
            other.title == title &&
            other.text == text &&
            other.time == time &&
            other.uri == uri &&
            other.jumpText == jumpText;
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, text, time, uri, jumpText);

  @override
  String toString() {
    return 'SystemNotice(id: $id, title: $title, text: $text, time: $time, '
        'uri: $uri, jumpText: $jumpText)';
  }
}

SystemNotice systemNoticeFromJson(Map<String, dynamic> json) {
  return SystemNotice(
    id: json['id'] as int? ?? 0,
    title: json['title'] as String?,
    text: json['text'] as String?,
    time: json['time'] as int? ?? 0,
    uri: json['uri'] as String?,
    jumpText: json['jump_text'] as String? ?? json['jumpText'] as String?,
  );
}

Map<String, dynamic> systemNoticeToJson(SystemNotice notice) {
  return {
    'id': notice.id,
    'title': notice.title,
    'text': notice.text,
    'time': notice.time,
    'uri': notice.uri,
    'jump_text': notice.jumpText,
  };
}
