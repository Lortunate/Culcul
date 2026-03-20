import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 使用 flutter_spinkit 实现的自定义刷新 Header
class SpinkitHeader extends Header {
  final Widget? spinWidget;
  final double height;
  final Color? color;
  final double size;

  const SpinkitHeader({
    this.spinWidget,
    this.height = 70,
    this.color,
    this.size = 30,
    super.triggerOffset = 70,
    super.clamping = false,
    super.position = IndicatorPosition.above,
    super.processedDuration = Duration.zero,
    super.spring,
    super.readySpringBuilder,
    super.frictionFactor,
    super.safeArea,
    super.infiniteOffset,
    super.hitOver,
    super.infiniteHitOver,
    super.hapticFeedback,
  });

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _SpinkitIndicator(
      state: state,
      spinWidget: spinWidget,
      height: height,
      color: color,
      size: size,
      isHeader: true,
    );
  }
}

/// 使用 flutter_spinkit 实现的自定义加载 Footer
class SpinkitFooter extends Footer {
  final Widget? spinWidget;
  final double height;
  final Color? color;
  final double size;
  final String? noMoreText;

  const SpinkitFooter({
    this.spinWidget,
    this.height = 70,
    this.color,
    this.size = 30,
    this.noMoreText,

    super.triggerOffset = 70,
    super.clamping = false,
    super.position = IndicatorPosition.above,
    super.processedDuration = Duration.zero,
    super.spring,
    super.readySpringBuilder,
    super.frictionFactor,
    super.safeArea,
    super.infiniteOffset,
    super.hitOver,
    super.infiniteHitOver,
    super.hapticFeedback,
  });

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _SpinkitIndicator(
      state: state,
      spinWidget: spinWidget,
      height: height,
      color: color,
      size: size,
      isHeader: false,
      noMoreText: noMoreText,
    );
  }
}

class _SpinkitIndicator extends StatefulWidget {
  final IndicatorState state;
  final Widget? spinWidget;
  final double height;
  final Color? color;
  final double size;
  final bool isHeader;
  final String? noMoreText;

  const _SpinkitIndicator({
    required this.state,
    this.spinWidget,
    required this.height,
    this.color,
    required this.size,
    required this.isHeader,
    this.noMoreText,
  });

  @override
  State<_SpinkitIndicator> createState() => _SpinkitIndicatorState();
}

class _SpinkitIndicatorState extends State<_SpinkitIndicator> {
  @override
  Widget build(BuildContext context) {
    final mode = widget.state.mode;
    final result = widget.state.result;
    final primaryColor = widget.color ?? Theme.of(context).primaryColor;

    // 默认使用 SpinKitThreeBounce，灵动且简约
    final defaultSpin = SpinKitThreeBounce(
      color: primaryColor,
      size: widget.size,
    );

    final child = widget.spinWidget ?? defaultSpin;

    if (!widget.isHeader && (result == IndicatorResult.noMore)) {
      return SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.noMoreText ?? 'No more',
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    // 根据状态控制显示
    if (mode == IndicatorMode.inactive ||
        mode == IndicatorMode.done ||
        mode == IndicatorMode.processed) {
      return const SizedBox.shrink();
    }

    double opacity = 1.0;
    if (mode == IndicatorMode.drag || mode == IndicatorMode.armed) {
      // 下拉/上拉过程中的透明度渐变
      opacity = (widget.state.offset.abs() / widget.state.actualTriggerOffset)
          .clamp(0.0, 1.0);
    }

    // 如果是 Footer，通常不需要像 Header 那样有大的位移空间，直接显示在底部即可
    // 这里统一使用 SizedBox 来限制高度
    return SizedBox(
      height: widget.state.offset.abs(), // 动态高度跟随拖拽
      width: double.infinity,
      child: Center(
        child: SizedBox(
          height: widget.height,
          child: Center(
            child: Opacity(opacity: opacity, child: child),
          ),
        ),
      ),
    );
  }
}
