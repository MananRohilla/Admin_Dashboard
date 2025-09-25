import 'package:flutter/material.dart';
import '../../core/utils/responsive_utils.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isMobile(context)) {
          return mobile;
        } else if (ResponsiveUtils.isTablet(context)) {
          return tablet ?? desktop;
        } else {
          return desktop;
        }
      },
    );
  }
}