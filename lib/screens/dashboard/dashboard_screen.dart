import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import 'mobile_dashboard.dart';
import 'tablet_dashboard.dart';
import 'desktop_dashboard.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: MobileDashboard(),
      tablet: TabletDashboard(),
      desktop: DesktopDashboard(),
    );
  }
}