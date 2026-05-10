part of 'danmaku_layer.dart';

DanmakuOption _buildDanmakuOption(DanmakuSettings settings) {
  return DanmakuOption(
    opacity: settings.opacity,
    area: settings.area,
    fontSize: 15 * settings.fontSizeScale,
    duration: 10 / settings.speed,
    hideTop: !settings.showTop,
    hideBottom: !settings.showBottom,
    hideScroll: !settings.showScroll,
    strokeWidth: settings.strokeWidth == 0 ? 1.5 : settings.strokeWidth,
    fontWeight: FontWeight.w500,
  );
}

DanmakuItemType _toDanmakuItemType(int mode) {
  return switch (mode) {
    4 => DanmakuItemType.bottom,
    5 => DanmakuItemType.top,
    _ => DanmakuItemType.scroll,
  };
}

Color _toOpaqueDanmakuColor(int colorValue) {
  return Color.fromARGB(
    255,
    (colorValue >> 16) & 0xFF,
    (colorValue >> 8) & 0xFF,
    colorValue & 0xFF,
  );
}

Path? _resolveMaskPath({
  required DanmakuSettings settings,
  required AsyncValue<Result<DanmakuMasks?, dynamic>> maskResultProvider,
  required int currentPosMs,
}) {
  if (!settings.enableAiMask || !maskResultProvider.hasValue) {
    return null;
  }
  final masks = maskResultProvider.value?.dataOrNull;
  if (masks == null) {
    return null;
  }
  return masks.getPath(currentPosMs);
}

class DanmakuMaskClipper extends CustomClipper<Path> {
  final Path? maskPath;
  final Size videoSize;

  DanmakuMaskClipper({required this.maskPath, required this.videoSize});

  @override
  Path getClip(Size size) {
    final rectPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    if (maskPath == null || videoSize.width == 0 || videoSize.height == 0) {
      return rectPath;
    }

    final scaleX = size.width / videoSize.width;
    final scaleY = size.height / videoSize.height;
    final matrix4 = Matrix4.diagonal3Values(scaleX, scaleY, 1.0);
    final scaledMask = maskPath!.transform(matrix4.storage);
    return Path.combine(PathOperation.difference, rectPath, scaledMask);
  }

  @override
  bool shouldReclip(covariant DanmakuMaskClipper oldClipper) {
    return oldClipper.maskPath != maskPath || oldClipper.videoSize != videoSize;
  }
}
