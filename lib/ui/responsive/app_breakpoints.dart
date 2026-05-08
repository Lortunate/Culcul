import 'package:responsive_framework/responsive_framework.dart';

class AppBreakpoints {
  AppBreakpoints._();

  static const double mobileStart = 0;
  static const double mobileEnd = 599;
  static const double tabletStart = 600;
  static const double tabletEnd = 1023;
  static const double desktopStart = 1024;
  static const double desktopEnd = 1439;
  static const double xlStart = 1440;

  static const String xl = 'XL';

  static const double shellExtendedRailStart = 1280;

  static const double pageMaxWidth = 1280;

  static const List<Breakpoint> frameworkBreakpoints = <Breakpoint>[
    Breakpoint(start: mobileStart, end: mobileEnd, name: MOBILE),
    Breakpoint(start: tabletStart, end: tabletEnd, name: TABLET),
    Breakpoint(start: desktopStart, end: desktopEnd, name: DESKTOP),
    Breakpoint(start: xlStart, end: double.infinity, name: xl),
  ];
}
