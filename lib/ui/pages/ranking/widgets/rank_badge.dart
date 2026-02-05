import 'package:flutter/material.dart';

class RankBadge extends StatelessWidget {
  final int rank;

  const RankBadge({
    super.key,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    
    // Bilibili-like ranking colors
    if (rank == 1) {
      backgroundColor = const Color(0xFFFF4757); // Red for No.1
    } else if (rank == 2) {
      backgroundColor = const Color(0xFFFFA502); // Orange for No.2
    } else if (rank == 3) {
      backgroundColor = const Color(0xFF3742FA); // Blue for No.3
    } else {
      backgroundColor = Colors.black.withValues(alpha: 0.4); // Semi-transparent black for others
    }

    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        '$rank',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          fontStyle: FontStyle.italic,
          height: 1,
        ),
      ),
    );
  }
}
