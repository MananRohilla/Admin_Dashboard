import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import 'mobile_dashboard.dart';
import 'tablet_dashboard.dart';
import 'desktop_dashboard.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const MobileDashboard(),
      tablet: const TabletDashboard(),
      desktop: const DesktopDashboard(),
    );
  }
}