enum VideoEntryLayout { normal, vertical }

({int width, int height}) normalizeVideoDimension({
  required int width,
  required int height,
  required int rotate,
}) {
  if (rotate == 1 || rotate == 90 || rotate == 270) {
    return (width: height, height: width);
  }
  return (width: width, height: height);
}

VideoEntryLayout inferVideoEntryLayoutFromDimension({
  required int width,
  required int height,
  required int rotate,
}) {
  final normalized = normalizeVideoDimension(
    width: width,
    height: height,
    rotate: rotate,
  );
  final normalizedWidth = normalized.width;
  final normalizedHeight = normalized.height;

  final isVertical =
      normalizedWidth > 0 && normalizedHeight > 0 && normalizedHeight > normalizedWidth;
  return isVertical ? VideoEntryLayout.vertical : VideoEntryLayout.normal;
}
