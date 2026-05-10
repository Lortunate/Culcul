part of 'interaction_layer.dart';

class _SeekDoubleTapOverlay extends StatelessWidget {
  const _SeekDoubleTapOverlay({
    required this.onSeekBackward,
    required this.onSeekForward,
  });

  final VoidCallback onSeekBackward;
  final VoidCallback onSeekForward;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onDoubleTapDown: (details) {
          final screenWidth = MediaQuery.sizeOf(context).width;
          if (details.globalPosition.dx < screenWidth * 0.2) {
            onSeekBackward();
          } else if (details.globalPosition.dx > screenWidth * 0.8) {
            onSeekForward();
          }
        },
        behavior: HitTestBehavior.translucent,
        child: const SizedBox.expand(),
      ),
    );
  }
}
