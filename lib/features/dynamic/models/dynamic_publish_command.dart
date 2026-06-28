final class PublishMediaAsset {
  const PublishMediaAsset({required this.path});

  final String path;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is PublishMediaAsset &&
            other.path == path;
  }

  @override
  int get hashCode => Object.hash(runtimeType, path);

  @override
  String toString() => 'PublishMediaAsset(path: $path)';
}
