import 'package:flutter/material.dart';

class RankBadge extends StatelessWidget {
  final int rank;

  const RankBadge({super.key, required this.rank});

  static const _rank1Gradient = LinearGradient(
    colors: [Color(0xFFD32F2F), Color(0xFFEF5350)], // Material Red 700 -> 400
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const _rank2Gradient = LinearGradient(
    colors: [Color(0xFFFFA502), Color(0xFFFFC048)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const _rank3Gradient = LinearGradient(
    colors: [Color(0xFF3742FA), Color(0xFF5352ED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const _shadowOffset = Offset(0, 2);
  static const _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    double size = 20;
    double fontSize = 12;

    if (rank == 1) {
      size = 24;
      fontSize = 14;
      decoration = const BoxDecoration(
        gradient: _rank1Gradient,
        borderRadius: _borderRadius,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DD32F2F),
            blurRadius: 4,
            offset: _shadowOffset,
          ),
        ],
      );
    } else if (rank == 2) {
      size = 24;
      fontSize = 14;
      decoration = const BoxDecoration(
        gradient: _rank2Gradient,
        borderRadius: _borderRadius,
        boxShadow: [
          BoxShadow(
            color: Color(0x4DFFA502),
            blurRadius: 4,
            offset: _shadowOffset,
          ),
        ],
      );
    } else if (rank == 3) {
      size = 24;
      fontSize = 14;
      decoration = const BoxDecoration(
        gradient: _rank3Gradient,
        borderRadius: _borderRadius,
        boxShadow: [
          BoxShadow(
            color: Color(0x4D3742FA),
            blurRadius: 4,
            offset: _shadowOffset,
          ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: _borderRadius,
      );
    }

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        '$rank',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          height: 1,
        ),
      ),
    );
  }
}
