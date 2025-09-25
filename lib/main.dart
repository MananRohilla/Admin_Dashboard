import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() {
  runApp(const AdStacksApp());
}

class AdStacksApp extends StatelessWidget {
  const AdStacksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdStacks Media Dashboard',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}