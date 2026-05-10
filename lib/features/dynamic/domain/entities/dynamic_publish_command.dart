class PublishMediaAsset {
  final String path;
  final int width;
  final int height;

  const PublishMediaAsset({
    required this.path,
    required this.width,
    required this.height,
  });
}

class PublishDynamicCommand {
  final String text;
  final List<PublishMediaAsset> media;

  const PublishDynamicCommand({
    required this.text,
    required this.media,
  });
}
