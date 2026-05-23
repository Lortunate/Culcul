class EmoteCatalogPackage {
  final int id;
  final String text;
  final String url;
  final List<EmoteCatalogItem> emotes;

  const EmoteCatalogPackage({
    required this.id,
    required this.text,
    required this.url,
    required this.emotes,
  });
}

class EmoteCatalogItem {
  final int id;
  final String text;
  final String url;

  const EmoteCatalogItem({required this.id, required this.text, required this.url});
}
