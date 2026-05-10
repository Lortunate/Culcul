class SystemNotice {
  final int id;
  final String? title;
  final String? text;
  final int time;
  final String? uri;
  final String? jumpText;

  const SystemNotice({
    required this.id,
    this.title,
    this.text,
    required this.time,
    this.uri,
    this.jumpText,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'text': text,
      'time': time,
      'uri': uri,
      'jump_text': jumpText,
    };
  }
}
