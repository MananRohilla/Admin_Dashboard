import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveUtils {
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppSizes.mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < AppSizes.tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
  
  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;
  
  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;
  
  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;
  
  static int getGridColumns(BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 4,
  }) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }
  
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}