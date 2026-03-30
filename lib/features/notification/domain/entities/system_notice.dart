class SystemNotice {
  final int id;
  final String? title;
  final String? text;
  final int time;
  final String? uri;
  final String? jumpText;

  const SystemNotice({
    required this.id,
    required this.title,
    required this.text,
    required this.time,
    required this.uri,
    required this.jumpText,
  });
}
