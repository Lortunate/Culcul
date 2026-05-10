part of 'interaction_layer.dart';

const double _brightnessStep = 0.01;
const double _volumeStep = 1.0;

enum _DragMode { idle, horizontal, vertical }

class _DragSession {
  double horizontalDelta = 0.0;
  double verticalDelta = 0.0;
  double verticalStartVolume = 0.0;
  double verticalStartBrightness = 0.0;
  double lastAppliedVolume = 0.0;
  double lastAppliedBrightness = 0.0;
  int lastVerticalUpdateMs = 0;

  void startHorizontal() {
    horizontalDelta = 0.0;
  }

  void startVertical({required double currentBrightness, required double currentVolume}) {
    verticalDelta = 0.0;
    verticalStartBrightness = currentBrightness;
    verticalStartVolume = currentVolume;
    lastAppliedBrightness = currentBrightness;
    lastAppliedVolume = currentVolume;
    lastVerticalUpdateMs = 0;
  }

  void reset({required double currentBrightness, required double currentVolume}) {
    horizontalDelta = 0.0;
    verticalDelta = 0.0;
    verticalStartBrightness = currentBrightness;
    verticalStartVolume = currentVolume;
    lastAppliedBrightness = currentBrightness;
    lastAppliedVolume = currentVolume;
    lastVerticalUpdateMs = 0;
  }
}
