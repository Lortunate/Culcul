import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class HomeBreakpoints {
  HomeBreakpoints._();

  static const double feedMaxWidth = 1280;
  static const double popularMaxWidth = 980;
}

extension HomeResponsive on BuildContext {
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
