part of 'player_settings_sheet.dart';

class _DanmakuSliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  const _DanmakuSliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: VideoOverlayStyles.titleStyle(
                  colorScheme,
                ).copyWith(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: VideoOverlayStyles.bodyStyle(
                colorScheme,
              ).copyWith(fontSize: 11.5, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: CulculSpacing.xs),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
