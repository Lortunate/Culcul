import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:flutter/material.dart';

extension AppResponsive on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;

  bool get isDesktopLayout => screenWidth >= AppBreakpoints.desktopStart;
  bool get isExtendedRailLayout => screenWidth >= AppBreakpoints.shellExtendedRailStart;

  double get pageHorizontalPadding {
    if (screenWidth >= AppBreakpoints.xlStart) {
      return 32;
    }
    if (screenWidth >= AppBreakpoints.desktopStart) {
      return 24;
    }
    if (screenWidth >= AppBreakpoints.tabletStart) {
      return 16;
    }
    return 8;
  }

  int get homeGridColumns {
    if (screenWidth >= AppBreakpoints.xlStart) {
      return 5;
    }
    if (screenWidth >= AppBreakpoints.desktopStart) {
      return 4;
    }
    if (screenWidth >= AppBreakpoints.tabletStart) {
      return 3;
    }
    return 2;
  }
}
