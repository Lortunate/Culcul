import 'package:flutter/material.dart';

abstract final class CulculSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

abstract final class CulculRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 28;

  static const Radius radiusXs = Radius.circular(xs);
  static const Radius radiusSm = Radius.circular(sm);
  static const Radius radiusMd = Radius.circular(md);
  static const Radius radiusLg = Radius.circular(lg);
  static const Radius radiusXl = Radius.circular(xl);
}

abstract final class CulculMotion {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration standard = Duration(milliseconds: 240);
  static const Duration emphasized = Duration(milliseconds: 280);

  static const Duration routeForward = standard;
  static const Duration routeModal = emphasized;
  static const Duration routeReverse = fast;

  static const Curve fadeScaleCurve = Curves.easeInOut;
  static const Curve routeSlideCurve = Curves.easeInOut;
  static const Curve modalSlideCurve = routeSlideCurve;
}
