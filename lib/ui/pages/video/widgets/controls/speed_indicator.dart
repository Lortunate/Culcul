import 'package:flutter/material.dart';

class SpeedIndicator extends StatelessWidget {
  const SpeedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fast_forward_rounded,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                '2.0x 倍速播放中',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
