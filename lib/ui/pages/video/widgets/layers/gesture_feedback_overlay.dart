import 'package:culcul/ui/pages/video/widgets/controls/gesture_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GestureFeedbackOverlay extends HookWidget {
  final ValueNotifier<bool> showIndicator;
  final ValueNotifier<IconData> indicatorIcon;
  final ValueNotifier<String> indicatorLabel;
  final ValueNotifier<double?> indicatorValue;
  final ValueNotifier<String?> indicatorTextValue;

  const GestureFeedbackOverlay({
    super.key,
    required this.showIndicator,
    required this.indicatorIcon,
    required this.indicatorLabel,
    required this.indicatorValue,
    required this.indicatorTextValue,
  });

  @override
  Widget build(BuildContext context) {
    final show = useValueListenable(showIndicator);
    final icon = useValueListenable(indicatorIcon);
    final label = useValueListenable(indicatorLabel);
    final value = useValueListenable(indicatorValue);
    final textValue = useValueListenable(indicatorTextValue);

    if (!show) return const SizedBox();

    return Center(
      child: GestureIndicator(
        icon: icon,
        label: label,
        value: value,
        textValue: textValue,
      ),
    );
  }
}
