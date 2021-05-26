import 'package:flutter/material.dart';
import 'package:reservaai/config/constants/screen_breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout(
      {Key? key,
      required this.mobileBody,
      required this.tabletBody,
      required this.desktopBody})
      : super(key: key);

  static bool isMobile(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return size.width < kTabletBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return size.width >= kTabletBreakpoint && size.width < kDesktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return size.width < kDesktopBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < kTabletBreakpoint) {
        return mobileBody;
      } else if (constraints.maxWidth < kDesktopBreakpoint) {
        return tabletBody;
      } else {
        return desktopBody;
      }
    });
  }
}
