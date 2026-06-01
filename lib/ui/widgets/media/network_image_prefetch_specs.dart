import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';

List<NetworkImagePrefetchSpec> buildNetworkImagePrefetchSpecs<T>(
  Iterable<T> items, {
  int startIndex = 0,
  required int count,
  required double logicalWidth,
  double? logicalHeight,
  double? aspectRatio,
  required double pixelRatio,
  required String Function(T item) imageUrl,
}) {
  assert(logicalHeight != null || aspectRatio != null);
  if (count <= 0) {
    return const <NetworkImagePrefetchSpec>[];
  }

  final itemList = items is List<T> ? items : items.toList(growable: false);
  if (itemList.isEmpty) {
    return const <NetworkImagePrefetchSpec>[];
  }

  final start = startIndex.clamp(0, itemList.length);
  if (start >= itemList.length) {
    return const <NetworkImagePrefetchSpec>[];
  }

  final end = (start + count).clamp(0, itemList.length);
  final memCacheWidth = (logicalWidth * pixelRatio).round();
  final effectiveLogicalHeight = logicalHeight ?? logicalWidth / aspectRatio!;
  final memCacheHeight = (effectiveLogicalHeight * pixelRatio).round();

  return itemList
      .sublist(start, end)
      .map(
        (item) => NetworkImagePrefetchSpec(
          url: imageUrl(item),
          memCacheWidth: memCacheWidth,
          memCacheHeight: memCacheHeight,
        ),
      )
      .toList(growable: false);
}
