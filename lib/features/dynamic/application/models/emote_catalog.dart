class EmotePackageViewData {
  final int id;
  final String text;
  final String url;
  final List<EmoteViewData> emotes;

  const EmotePackageViewData({
    required this.id,
    required this.text,
    required this.url,
    required this.emotes,
  });
}

class EmoteViewData {
  final int id;
  final String text;
  final String url;

  const EmoteViewData({required this.id, required this.text, required this.url});
}
